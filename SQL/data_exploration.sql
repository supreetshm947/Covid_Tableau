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

select distinct location from covid_deaths where continent like '%America';

--continents with highest deaths
select continent, max(total_deaths) as death_count from covid_deaths
where continent is not null
Group by continent order by death_count desc;

--global covid numbers for each day
select date, sum(new_cases) as total_cases, sum(new_deaths) 
as total_deaths, (sum(new_deaths)::real/sum(new_cases)::real)*100 as death_rate
from covid_deaths where continent is not null 
and total_cases is not null and total_deaths is not null
Group by date order by death_rate desc;


--global covid numbers in total
select sum(new_cases) as total_cases, sum(new_deaths) 
as total_deaths, (sum(new_deaths)::real/sum(new_cases)::real)*100 as death_rate
from covid_deaths where continent is not null 
and total_cases is not null and total_deaths is not null
order by death_rate desc;

--covid vaccinations vs populations by date using paging function
--partition starts over aggregate function wherver the by col changes value
--order by in partition makes the aggregate run only when value changes for aggregate col(new_vacc) for the order by col(date)
select dea.location, dea.date, dea.population, vacc.new_vaccinations,
sum(vacc.new_vaccinations) over (partition by dea.location 
order by dea.date) as total_vaccinations
from covid_deaths dea join covid_vaccinations vacc on 
dea.location = vacc.location and dea.date = vacc.date
where dea.continent is not null
order by 1,2;

--using declared variables -> 2 methods CTE and create temp table
--CTE - Common Table Expression
with vacc_n_pop (location, date, population, new_vaccination, total_vaccinations)
as
(
	select dea.location, dea.date, dea.population, vacc.new_vaccinations,
	sum(vacc.new_vaccinations) over (partition by dea.location 
	order by dea.date) as total_vaccinations
	from covid_deaths dea join covid_vaccinations vacc on 
	dea.location = vacc.location and dea.date = vacc.date
	where dea.continent is not null
	order by 1,2
)
select location, date, (total_vaccinations::real/population::real)*100 as vaccination_rate
from vacc_n_pop ;

--create temp table method
drop table if exists vac_n_pop;
create table vac_n_pop(
	location VARCHAR(40),
	date DATE,
	population real,
	new_vaccination real,
	total_vaccinations real
);
insert into vac_n_pop
	select dea.location, dea.date, dea.population, vacc.new_vaccinations,
	sum(vacc.new_vaccinations) over (partition by dea.location 
	order by dea.date) as total_vaccinations
	from covid_deaths dea join covid_vaccinations vacc on 
	dea.location = vacc.location and dea.date = vacc.date
	where dea.continent is not null
	order by 1,2;
select location, date, (total_vaccinations::real/population::real)*100 as vaccination_rate
from vac_n_pop ;

--create view for covid vaccinations vs populations
create view vac_n_pop_view as
	select dea.location, dea.date, dea.population, vacc.new_vaccinations,
	sum(vacc.new_vaccinations) over (partition by dea.location 
	order by dea.date) as total_vaccinations
	from covid_deaths dea join covid_vaccinations vacc on 
	dea.location = vacc.location and dea.date = vacc.date
	where dea.continent is not null
	order by 1,2;
	
select * from vac_n_pop_view;