

declare @today_date as date
declare @n as int
set @today_date = '2024-08-03'
set @n = 3


select dateadd(week,@n-1,dateadd(day,(8-datepart(weekday,@today_date)),@today_date))

/*sunday - 1
....
...
...
...
saturday = 7 */
