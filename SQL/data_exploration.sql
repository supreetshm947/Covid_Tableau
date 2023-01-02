--deaths rate wrt infections - likelihood of dying if you caught covid
select location, date, population, total_cases, new_cases, total_deaths,
(total_deaths::real/total_cases::real)*100 as death_rate from covid_deaths order by 1,2;

--death rate in india
select location, date, population, total_cases, new_cases, total_deaths,
(total_deaths::real/total_cases::real)*100 as death_rate from covid_deaths
where location='India' order by 1,2;

--getting countries with highest infection
select location, population,
MAX(total_cases) as total_cases from covid_deaths where 
total_cases is not NULL Group by location, population
order by total_cases DESC;

--countries with highest infection rate 
select location, population, max(total_cases::real/population::real)*100 
as infection_rate from covid_deaths where population is not null 
and total_cases is not null Group by location, population 
order by infection_rate desc;

--countries with highest death count per population
select location, population, MAX(total_deaths) as death_count from 
covid_deaths where total_deaths is not null Group by location, population
order by death_count desc;
