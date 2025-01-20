select *
from layoffs;
create table layoff1
like layoffs;
insert layoff1
select *
from layoffs;
select *
from layoff1;
select *, row_number() over(partition by company, location,industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs;

CREATE TABLE `layoff2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
insert into layoff2
select *, row_number() over(partition by company, location,industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs;
delete
from layoff2
where row_num>1;
select company, trim(company )
from layoff2;
update layoff2
set company = trim(company);
select distinct industry
from layoff2
order by 1;
update layoff2
set industry = "Crypto"
where industry like "Crypto%";
select distinct country
from layoff2
order by 1;
select distinct country
from layoff2
order by 1;
update layoff2
set country = trim(trailing"." from country)
where country like "United States%";
select `Date`, str_to_date(`Date`,"%m/%d/%Y")
from layoff2;
update layoff2
set `Date` = str_to_date(`Date`,"%m/%d/%Y");
SELECT 
    `Date`
FROM
    layoff2;
ALTER TABLE layoff2
MODIFY COLUMN `Date` Date;

select *
from layoff2
where total_laid_off is null and percentage_laid_off is null;
update layoff2
set industry = null
where industry ='';
select *
from layoff2
where industry is null or industry = '';

select *
from layoff2
where company = "Airbnb";

select t1.industry, t2.industry
from layoff2 t1
join layoff2 t2
on t1.company=t2.company and t1.location=t2.location
where (t1.industry is null or t1.industry ='') and t2.industry is not null;
update layoff2 t1
join layoff2 t2
on t1.company=t2.company and t1.location=t2.location
set t1.industry=t2.industry
where  t1.industry is null  and t2.industry is not null;
select *
from layoff2;
select *
from layoff2
where total_laid_off is null and percentage_laid_off is null;
delete
from layoff2
where total_laid_off is null and percentage_laid_off is null;
SELECT 
    *
FROM
    layoff2;
alter table layoff2
drop column row_num;

