create procedure mappingBD 
    @obj varchar(100) 
as

declare @result TABLE
(
   linha varchar(max)
)

insert into @result  values ('[Table("'+@obj+'")]')
insert into @result  values ('public class '+@obj)
insert into @result  values ('{')
insert into @result  values (' ')

 DECLARE @coluna VARCHAR(max);
 DECLARE @tipo VARCHAR(max);
 DECLARE @tamanho VARCHAR(max);
 DECLARE @isnull int;

--Declara cursor
DECLARE cTeste CURSOR FOR

    SELECT    
        B.[name] AS coluna,
        C.[name] AS tipo,
        B.max_length as tamanho ,
        B.[is_nullable] AS isnull 
    FROM
        sys.objects A
        JOIN sys.columns B ON B.[object_id] = A.[object_id]
        JOIN sys.types C ON B.user_type_id = C.user_type_id
        JOIN sys.types D ON B.system_type_id = D.user_type_id
    WHERE a.name = @obj


--Abre cursor
OPEN cTeste
FETCH NEXT FROM cTeste
INTO @coluna,@tipo,@tamanho,@isnull

--Percorre Cursor
WHILE @@FETCH_STATUS = 0
BEGIN


declare @titpodotnet varchar(max)

set @titpodotnet = (case @tipo
	                    WHEN 'binary'		  then 'byte'
                        WHEN 'varchar'		  then 'string'
                        WHEN 'char'           then 'string'       
                        WHEN 'nvarchar'		  then 'string'
                        WHEN 'nchar'		  then 'string'	
                        WHEN 'bit'            then 'Boolean'  + (case when @isnull = 1 then '?'  else '' end)
                        WHEN 'tinyint'        then 'byte' 
                        WHEN 'smallint'       then 'Int16'  + (case when @isnull = 1 then '?'  else '' end)
                        WHEN 'int'            then 'Int32'  + (case when @isnull = 1 then '?'  else '' end)
                        WHEN 'bigint'         then 'Int64' + (case when @isnull = 1 then '?'  else '' end)
                        WHEN 'smallmoney'     then 'decimal'  
                        WHEN 'money'          then 'decimal'  
                        WHEN 'numeric'        then 'decimal'  
                        WHEN 'decimal'        then 'decimal'  
                        WHEN 'float'          then 'double'  
                        WHEN 'smalldatetime'  then 'DateTime'  + (case when @isnull = 1 then '?'  else '' end)
                        WHEN 'datetime'       then 'DateTime' + (case when @isnull = 1 then '?'  else '' end)
                        else 'Tipo não Encontrado' 
               end)

insert into @result  values ('[Column("'+ upper(left(@coluna,1))+''+ RIGHT(@coluna, len(@coluna) -1 ) +'")]')
insert into @result  values ('public '+ @titpodotnet +' '+ @coluna+ ' { get; set; }')
insert into @result  values (' ')
  
FETCH NEXT FROM cTeste
INTO @coluna,@tipo,@tamanho,@isnull
END

--Fecha Cursor
CLOSE cTeste
DEALLOCATE cTeste

insert into @result  values ('}')

select * from @result