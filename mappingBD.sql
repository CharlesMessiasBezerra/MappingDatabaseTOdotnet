--1º - Mapear Tabela        
--exec mappingDB 'RAV09000',1;        
​        
--2º - Criando DTO        
--exec mappingDB 'RAV09000',2;        
​        
--3º - Passando valores DTO        
--exec mappingDB 'RAV09000',3;        
​        
--4º - Grid - Front         
--exec mappingDB 'RAV09000',4;         
            
alter procedure mappingDB              
 @obj varchar(100) ,            
 @tipoFiltro int = 1            
as                  
                  
declare @result TABLE                  
(                  
   linha varchar(max)                  
)                  
                 
  DECLARE @coluna VARCHAR(max);                  
  DECLARE @tipo VARCHAR(max);                  
  DECLARE @tamanho VARCHAR(max);                  
  DECLARE @isnull int;                  
  DECLARE @titpodotnet varchar(max);                  
  DECLARE @titpoFront varchar(max);             
  DECLARE @Nomecoluna varchar(max);             
  DECLARE @PrimeiraColuna varchar(max);             
              
               
            
if(@tipoFiltro = 1)            
begin             
 insert into @result  values ('[Table("'+@obj+'")]')                  
 insert into @result  values ('public class '+@obj)                  
 insert into @result  values ('{')                  
 insert into @result  values (' ')                  
                  
            
                  
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
                  
                  
            
                  
 set @titpodotnet = (case @tipo                  
       WHEN 'binary'     then 'byte'                  
       WHEN 'varchar'    then 'string'                  
       WHEN 'char'     then 'string'                         
       WHEN 'nvarchar'       then 'string'                  
       WHEN 'nchar'          then 'string'                   
       WHEN 'bit'            then 'Boolean'  + (case when @isnull = 1 then '?'  else '' end)                  
       WHEN 'tinyint'        then 'byte'                   
       WHEN 'smallint'       then 'short'  + (case when @isnull = 1 then '?'  else '' end)                  
       WHEN 'int'            then 'int'  + (case when @isnull = 1 then '?'  else '' end)                  
       WHEN 'bigint'         then 'Int' + (case when @isnull = 1 then '?'  else '' end)                  
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
 end            
            
              
          
            
if(@tipoFiltro = 2)            
begin             
 
 insert into @result values ('public class '+@obj+'Dto')                  
 insert into @result  values ('{')                  
 insert into @result  values (' ')                  
                  
            
                  
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
                  
                  
            
                  
 set @titpodotnet = (case @tipo                  
       WHEN 'binary'     then 'byte'                  
       WHEN 'varchar'    then 'string'                  
       WHEN 'char'     then 'string'                         
       WHEN 'nvarchar'       then 'string'                  
       WHEN 'nchar'          then 'string'                   
       WHEN 'bit'            then 'Boolean'  + (case when @isnull = 1 then '?'  else '' end)                  
       WHEN 'tinyint'        then 'byte'                   
       WHEN 'smallint'       then 'short'  + (case when @isnull = 1 then '?'  else '' end)                  
       WHEN 'int'            then 'int'  + (case when @isnull = 1 then '?'  else '' end)                  
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
                  
          
 insert into @result  values ('public '+ @titpodotnet +' '+ @coluna+ ' { get; set; }')                  
 insert into @result  values ('')                  
                    
 FETCH NEXT FROM cTeste                  
 INTO @coluna,@tipo,@tamanho,@isnull                  
 END                  
                  
 --Fecha Cursor                  
 CLOSE cTeste                  
 DEALLOCATE cTeste                  
                  
 insert into @result  values ('}')                  
                  
 select * from @result                  
 end            
            
              
            
if(@tipoFiltro = 3)            
begin             
              
              
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
                  
                  
            
 set @Nomecoluna = upper(left(@coluna,1))+''+ RIGHT(@coluna, len(@coluna) -1 );            
 insert into @result  values (@Nomecoluna +' = x.'+@Nomecoluna +', ')                  
            
                    
 FETCH NEXT FROM cTeste                  
 INTO @coluna,@tipo,@tamanho,@isnull                  
 END                  
                  
 --Fecha Cursor                  
 CLOSE cTeste                  
 DEALLOCATE cTeste                  
                  
                  
 select * from @result                  
 end            
            
            
 if(@tipoFiltro = 4)            
begin            
            
 insert into @result  values ('            return {')                
 insert into @result  values ('                filter: {')                
 insert into @result  values ('                    parameters: [],')                
 insert into @result  values ('')                
 insert into @result  values ('                    filterItens: [')                
            
                  
                  
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
                                 
 set @titpoFront = (case @tipo                  
       WHEN 'varchar'        then ', type: ''text'', headerSize:2.1'    
       WHEN 'char'           then ', type: ''text'', headerSize:2.1'     
       WHEN 'nvarchar'       then ', type: ''text'', headerSize:2.1'    
       WHEN 'nchar'          then ', type: ''text'', headerSize:2.1'    
       WHEN 'bit'            then ', type: ''lista'', array: gridFilterArrayFactory.getTipoSimNaoString(), arrayType: ''text'', headerSize: 0.98  ' + (case when @isnull = 1 then ', isNullable: true'  else '' end)                              
       WHEN 'tinyint'        then ', type: ''number'', headerSize: 1.3, isShort: true' + (case when @isnull = 1 then ', isNullable: true'  else '' end)                         
       WHEN 'smallint'       then ', type: ''number'',  isByte: true, headerSize: 1.95' + (case when @isnull = 1 then ', isNullable: true'  else '' end)                           
       WHEN 'int'            then ', type: ''number'', headerSize: 1.3' + (case when @isnull = 1 then ', isNullable: true'  else '' end)                         
       WHEN 'bigint'         then ', type: ''number'', headerSize: 1.3' + (case when @isnull = 1 then ', isNullable: true'  else '' end)                         
       WHEN 'smallmoney'     then ', type: ''decimal'',  headerSize: 1.3' + (case when @isnull = 1 then ', isNullable: true'  else '' end)                         
       WHEN 'money'          then ', type: ''decimal'',  headerSize: 1.3' + (case when @isnull = 1 then ', isNullable: true'  else '' end)                         
       WHEN 'numeric'        then ', type: ''decimal'',  headerSize: 1.3' + (case when @isnull = 1 then ', isNullable: true'  else '' end)                                
       WHEN 'decimal'        then ', type: ''decimal'',  headerSize: 1.3' + (case when @isnull = 1 then ', isNullable: true'  else '' end)                                
       WHEN 'float'          then ', type: ''number'', headerSize: 1.3' + (case when @isnull = 1 then ', isNullable: true'  else '' end)                                
       WHEN 'smalldatetime'  then ', type: ''date'', headerSize: 2' + (case when @isnull = 1 then ', isNullable: true'  else '' end)                             
       WHEN 'datetime'       then ', type: ''date'', headerSize: 2'+ (case when @isnull = 1 then ', isNullable: true'  else '' end)                              
       else 'Tipo não Encontrado'                   
       end)                  
                  
    set @Nomecoluna = upper(left(@coluna,1))+''+ RIGHT(@coluna, len(@coluna) -1 );            
            
 insert into @result  values ('                        { fieldName: '''+ @Nomecoluna +''', dataName: '''+ @Nomecoluna +''', show: true'+ @titpoFront + ' },'  )                  
            
 if(@PrimeiraColuna is null)            
 begin             
     set @PrimeiraColuna ='                        { fieldName: '''+@Nomecoluna+''', dataName: '''+@Nomecoluna+''', order: ''A'' },'            
 end             
            
          
 FETCH NEXT FROM cTeste                  
 INTO @coluna,@tipo,@tamanho,@isnull                  
 END                  
                  
 --Fecha Cursor                  
 CLOSE cTeste                  
 DEALLOCATE cTeste                  
                
             
 insert into @result  values ('                    ],')                  
 insert into @result  values ('                    filterOrder: [')                  
 insert into @result  values (@PrimeiraColuna)                  
 insert into @result  values ('                    ],')                  
 insert into @result  values ('                    filterVersion: '''+replace(convert(varchar,getdate(),102),'.','')+replace(convert(varchar,getdate(),108),':','')+''',')                  
             
 insert into @result  values ('                },')                  
 insert into @result  values ('                resultsDisplay: [')                  
 insert into @result  values (' ')                  
 insert into @result  values ('                ],')                  
 insert into @result  values ('  recurso: ''Nome do Seu Recurso''')                  
 insert into @result  values ('            };')                  
                  
 select * from @result                  
end
