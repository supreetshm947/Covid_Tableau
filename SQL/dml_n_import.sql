--create table covid_deaths
create table covid_deaths (
	iso_code VARCHAR(10),
	continent VARCHAR(20),
	location VARCHAR(40),
	date DATE,
	population bigint,
	total_cases int,
	new_cases int,
	new_cases_smoothed real,
	total_deaths int,
	new_deaths int,
	new_deaths_smoothed real,
	total_cases_per_million real,
	new_cases_per_million real,
	new_cases_smoothed_per_million real,
	total_deaths_per_million real,
	new_deaths_per_million real,
	new_deaths_smoothed_per_million real,
	reproduction_rate real,
	icu_patients int,
	icu_patients_per_million real,
	hosp_patients int,
	hosp_patients_per_million real,
	weekly_icu_admissions int,
	weekly_icu_admissions_per_million real,
	weekly_hosp_admissions int,
	weekly_hosp_admissions_per_million real
)

--import data from csv to covid_death
copy covid_deaths FROM '/private/tmp/covid_deaths.csv' DELIMITER ',' CSV HEADER;
set datestyle = "ISO,YMD";
show datestyle;
select * from covid_deaths;

--create table covid_vacinations
create table covid_vaccinations (
	iso_code VARCHAR(10),
	continent VARCHAR(20),
	location VARCHAR(40),
	date DATE,
	total_tests int,
	new_tests bigint,
	total_tests_per_thousand real,
	new_tests_per_thousand real,
	new_tests_smoothed real,	
	new_tests_smoothed_per_thousand	real,
	positive_rate real,
	tests_per_case	real,
	tests_units	varchar(20),
	total_vaccinations bigint,
	people_vaccinated	bigint,
	people_fully_vaccinated	bigint,
	total_boosters	bigint,
	new_vaccinations	int,
	new_vaccinations_smoothed	real,
	total_vaccinations_per_hundred	real,
	people_vaccinated_per_hundred	real,
	people_fully_vaccinated_per_hundred	real,
	total_boosters_per_hundred	real,
	new_vaccinations_smoothed_per_million	real,
	new_people_vaccinated_smoothed	real,
	new_people_vaccinated_smoothed_per_hundred	real,
	stringency_index	real,
	population_density	real,
	median_age	real,
	aged_65_older	real,
	aged_70_older	real,
	gdp_per_capita	real,
	extreme_poverty	real,
	cardiovasc_death_rate	real,
	diabetes_prevalence	real,
	female_smokers	real,
	male_smokers	real,
	handwashing_facilities	real,
	hospital_beds_per_thousand	real,
	life_expectancy	real,
	human_development_index real,
	excess_mortality_cumulative_absolute real,
	excess_mortality_cumulative real,
	excess_mortality real,
	excess_mortality_cumulative_per_million real
);

--import data from csv to covid_vaccinations table
copy covid_vaccinations FROM '/private/tmp/covid_vaccinations.csv' DELIMITER ',' CSV HEADER;

select * from covid_vaccinations;