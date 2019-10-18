use nhs;

drop table SleepingPills2013
drop table Sleepingpillloactions2013;
drop table [T201812ADDR BNFT]


select top 10 * from [practices18]
select top 10 * from [prescriptions18]

alter table practices18 drop column [Column 0]
alter table practices10 drop column [Column 8]

--CREATE NONCLUSTERED INDEX prescriptions12   
--ON prescriptions12 ([BNF NAME]); 


alter table prescriptions16 drop column [Column 10]

drop table SleepingPillsyear

select  * Into SleepingPillsyear from [dbo].[prescriptions18] Where  
    [BNF NAME]  like '%chloral%' Or 
    [BNF NAME] like '%circadin%' Or 
    [BNF NAME] like '%diphenhydramine%' Or  
    [BNF NAME] like '%clomethiazole%' OR  
    [BNF NAME] like '%chlormethiazole%' OR  
    [BNF NAME] like '%melatonin%' OR  
    [BNF NAME] like '%promethazine%' OR 
    [BNF NAME] like '%diphenhydramine%' OR 
    [BNF NAME] like '%Zopiclone%' OR 
    [BNF NAME] like '%zolpidem%' OR 
    [BNF NAME] like '%zaleplon%' OR
	[BNF NAME] like '%alprazolam%' OR
	[BNF NAME] like '%alazin%' OR
	[BNF NAME] like '%ativan%' OR 
	[BNF NAME] like '%buspirone%' OR 
	[BNF NAME] like '%chlordiazepoxide%' OR  
	[BNF NAME] like '%dalmane%' OR 
	[BNF NAME] like '%dialar%' OR 
	[BNF NAME] like '%meprobamaten%' OR 
	[BNF NAME] like '%pregabalin%' 

select top 10 * from SleepingPillsyear
select top 10 * from practices18

--EXEC sp_rename 'dbo.practices11.Columnn 1', 'Practice Code', 'COLUMN';

drop table Sleepingpilllocationsyear

select  * into Sleepingpilllocationsyear from SleepingPillsyear Left outer join practices18 as prac ON SleepingPillsyear.PRACTICE = prac.[Practice Code]; 

select top 10 * from Sleepingpilllocationsyear

alter table Sleepingpilllocationsyear drop column PRACTICE;

select top 20 * from Sleepingpilllocationsyear; 
select top 20 * from Sleepingpill2011_2013_2015;

--drop table Sleepingpill2010_2011_2012_2013_2015_2017 

drop table Sleepingpill2010_2011_2012_2013_2014_2015_2016_2017

Select * into Sleepingpillallyears From Sleepingpill2010_2011_2012_2013_2014_2015_2016_2017 UNION 
select * from Sleepingpilllocationsyear 

select distinct [BNF NAME] from sleepingpillallyears
( select * from Sleepingpillallyears where [BNF NAME] like '%diphenhydramine%') as a

delete from Sleepingpillallyears where [BNF NAME] like '%DichlorAlc/Amylmet_Loz 1.2mg/600mcg S/F%'

select top 20 * from Sleepingpillallyears

alter table Sleepingpillallyears add [BNF CODE 2] nvarchar(20)

update Sleepingpillallyears Set [BNF CODE 2] = substring(Sleepingpillallyears.[BNF CODE],1,9)

select * into NHSSleepingPills from sleepingpillallyears left outer join dbo.[CHEM SUBS] AS CHEM on sleepingpillallyears.[BNF CODE 2] = [CHEM].[CHEM SUB]

select top 20 * from [CHEM SUBS]

alter table [CHEM SUBS] drop column [201812]

select distinct [ SHA] from NHSSleepingPills;
select county, [ SHA] from NHSSleepingPills;

select top 10 * from NHSSleepingpills;

select * from NHSSleepingPills where county Like '%Blackpool%'
EXCEPT 
select * from NHSSleepingPills where county = 'Blackpool' --or where county ='' 

select * into NHSSleepingPills_Populations from  NHSSleepingPills left outer join [2011_counties_populations] AS pop on NHSSleepingPills.County =pop.[geography]

/*update [2011_counties_populations] SET [geography] = 
CASE
WHEN [geography] LIKE '%Cheshire%' Then 'Cheshire' 
WHEN [geography] LIKE '%Durham%' Then 'Durham' 
WHEN [geography] LIKE '%Hartlepool%' Then 'Durham' 
WHEN [geography] LIKE '%Middlesborough%' Then 'North Yourkshire' 
WHEN [geography] LIKE '%Redcar and Cleveland%' Then 'North Yorkshire' 
WHEN [geography] LIKE '%Stockton-on-Tees%' Then 'Durham' 
WHEN [geography] LIKE '%Gateshead%' Then 'Tyne & Wear' 
WHEN [geography] LIKE '%Newcastle upon Tyne%' Then 'Tyne & Wear' 
WHEN [geography] LIKE '%Tyneside%' Then 'Tyne & Wear' 
WHEN [geography] LIKE '%Sunderland%' Then 'Tyne & Wear' 
WHEN [geography] LIKE '%Blackburn with Darwen%' Then 'Lancashire' 
WHEN [geography] LIKE '%Blackpool%' Then 'Lancashire' 
WHEN [geography] LIKE '%Halton%' Then 'Cheshire' 
WHEN [geography] LIKE '%Warrington%' Then 'Cheshire' 
WHEN [geography] LIKE '%Bolton%' Then 'cheshire' 
WHEN [geography] LIKE '%%' Then '' 
WHEN [geography] LIKE '%%' Then '' 
WHEN [geography] LIKE '%%' Then '' 
WHEN [geography] LIKE '%%' Then ''

ELSE [geography] 
END;  */

select * from [Final County Populations]

select * from NHSSleepingPills_Populations where Variable_All_usual_residents_measures_Value IS NULL;



alter table NHSSleepingPills add [County 2] nvarchar(50);

select * from NHSSleepingPills


drop table NHSSleepingPillsCountyPopulations

Select * from NHSSleepingPills

drop table [Final County Population]


select * into NHSSleepingPillsCountyPopulations from  NHSSleepingPills left outer join [Final County Populations] AS pop on NHSSleepingPills.County =pop.[Geographical County]

select * from NHSSleepingPillsCountyPopulations Where County = 'Surrey'

alter table NHSSleepingPillsCountyPopulations drop column [BNF CODE 2]

alter table NHSSleepingPillsCountyPopulations ADD Postcode2 varchar(10);

UPDATE NHSSleepingPillsCountyPopulations SET Postcode2 = replace( substring(Postcode, 1, charindex(' ', Postcode) + 1), ' ','') ; 

alter table NHSSleepingPillsCountyPopulations drop column [County 2]

