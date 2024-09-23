




---Help me build a list of riders who took trips on 5 consecutive days 
---in January 2017 in New York City.


WITH C1 AS (
    SELECT 
        t.tripid, 
        t.riderid, 
        t.cityid, 
        DATE_FORMAT(t.trip_timestamp, "YYYY-MM-DD") AS trip_date 
    FROM trip t
    LEFT JOIN city c ON c.cityid = t.cityid
    WHERE c.cityname = 'NewYork'
    AND DATE_FORMAT(t.trip_timestamp, "YYYY-MM-DD") BETWEEN '2017-01-01' AND '2017-01-31'
),
C2 AS (
    SELECT 
        tripid, 
        riderid, 
        cityid, 
        trip_date,
        ROW_NUMBER() OVER (PARTITION BY riderid ORDER BY trip_date ASC) AS rn,
        DATEDIFF(trip_date, '2017-01-01') - ROW_NUMBER() OVER (PARTITION BY riderid ORDER BY trip_date ASC) AS difference
    FROM C1
),
C3 AS (
    SELECT 
        riderid, 
        COUNT(*) OVER (PARTITION BY riderid, difference) AS consecutive_days
    FROM C2
)
SELECT DISTINCT riderid 
FROM C3
WHERE consecutive_days >= 5;
