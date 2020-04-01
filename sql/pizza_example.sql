declare @json NVARCHAR(max);
SELECT @json = BulkColumn
 FROM OPENROWSET (BULK 'C:\Users\Daniel\Downloads\pizza.json', SINGLE_CLOB) as j

SELECT *, IDENTITY(int) as id
INTO #temp
FROM OPENJSON(@json)
  WITH (
    toppings NVARCHAR(max) '$.toppings' as JSON
  )


Select toppings, count('Col3') as CC
    into #temp1
    from #temp
    group by toppings
    order by toppings

select * from #temp1
    where CC > 10
    group by toppings, CC
    order by CC DESC