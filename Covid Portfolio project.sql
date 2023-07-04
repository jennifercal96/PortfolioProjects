Select *
From [Portfolio project]..CovidDeaths
order by 3,4

----Select *
----From [Portfolio project]..CovidVaccinations
----order by 3,4

ALTER TABLE CovidDeaths ALTER COLUMN total_cases FLOAT
ALTER TABLE CovidDeaths ALTER COLUMN total_deaths FLOAT
ALTER TABLE CovidDeaths ALTER COLUMN total_cases_per_million FLOAT
ALTER TABLE CovidDeaths ALTER COLUMN total_deaths_per_million FLOAT


Select location, date total_cases, new_cases, total_deaths, Population_density 
From [Portfolio project]..CovidDeaths 
order by 1,2


Select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
From [Portfolio project]..CovidDeaths
order by 1,2

--Wanted to chech the values from other Countries---

Select location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From [Portfolio project]..CovidDeaths
Where location like '%Colombia%'
order by 1,2

Select location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From [Portfolio project]..CovidDeaths
Where location like '%Mexico%'
order by 1,2

Select location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From [Portfolio project]..CovidDeaths
Where location like '%France%'
order by 1,2

Select location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From [Portfolio project]..CovidDeaths
Where location like '%China%'
order by 1,2

Select location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From [Portfolio project]..CovidDeaths
Where location like '%States%'
order by 1,2

Select location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From [Portfolio project]..CovidDeaths
Where location like '%Bolivia'
order by 1,2

Select location,date,total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From [Portfolio project]..CovidDeaths
Where location like '%Brazil%'
order by 1,2


--Looking at the Total cases vs Population

Select location,date,total_cases,Population_density, (total_deaths/Population_density)*100 as PercentPopulationInfected
From [Portfolio project]..CovidDeaths
Where location like '%Colombia%'
order by 1,2

Select location,date,total_cases,Population_density, (total_deaths/Population_density)*100 as PercentPopulationInfected
From [Portfolio project]..CovidDeaths
Where location like '%Mexico%'
order by 1,2

Select location,date,total_cases,Population_density, (total_deaths/Population_density)*100 as PercentPopulationInfected
From [Portfolio project]..CovidDeaths
Where location like '%France%'
order by 1,2

Select location,date,total_cases,Population_density, (total_deaths/Population_density)*100 as PercentPopulationInfected
From [Portfolio project]..CovidDeaths
Where location like '%China%'
order by 1,2

Select location,date,total_cases,Population_density, (total_deaths/Population_density)*100 as PercentPopulationInfected
From [Portfolio project]..CovidDeaths
Where location like '%States%'
order by 1,2

Select location,date,total_cases,Population_density, (total_deaths/Population_density)*100 as PercentPopulationInfected
From [Portfolio project]..CovidDeaths
Where location like '%Bolivia%'
order by 1,2

Select location,date,total_cases,Population_density, (total_deaths/Population_density)*100 as PercentPopulationInfected
From [Portfolio project]..CovidDeaths
Where location like '%Brazil%'
order by 1,2


--Looking at countries with the Highest Infection rate compared to Population


Select location,Population_density, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/Population_density))*100 as PercentPopulationInfected
From [Portfolio project]..CovidDeaths
Where location like '%Colombia%'
group by location,Population_density
order by PercentPopulationInfected desc

Select location,Population_density, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/Population_density))*100 as PercentPopulationInfected
From [Portfolio project]..CovidDeaths
Where location like '%States%'
group by location,Population_density
order by PercentPopulationInfected desc

Select location,Population_density, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/Population_density))*100 as PercentPopulationInfected
From [Portfolio project]..CovidDeaths
Where location like '%China%'
group by location,Population_density
order by PercentPopulationInfected desc

Select location,Population_density, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/Population_density))*100 as PercentPopulationInfected
From [Portfolio project]..CovidDeaths
Where location like '%France%'
group by location,Population_density
order by PercentPopulationInfected desc

Select location,Population_density, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/Population_density))*100 as PercentPopulationInfected
From [Portfolio project]..CovidDeaths
Where location like '%Mexico%'
group by location,Population_density
order by PercentPopulationInfected desc

Select location,Population_density, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/Population_density))*100 as PercentPopulationInfected
From [Portfolio project]..CovidDeaths
Where location like '%Bolivia%'
group by location,Population_density
order by PercentPopulationInfected desc

Select location,Population_density, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/Population_density))*100 as PercentPopulationInfected
From [Portfolio project]..CovidDeaths
Where location like '%Brazil%'
group by location,Population_density
order by PercentPopulationInfected desc



--Showing the countries with the Highest Death Count per Population


 Select location, MAX(total_deaths) as TotalDeathCount
From [Portfolio project]..CovidDeaths
--Where location like '%Colombia%'
where continent is not null
group by location
order by TotalDeathCount desc

--Separating Things Down by Continent

Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From [Portfolio project]..CovidDeaths
--Where location like '%Colombia%'
where continent is not null
group by continent
order by TotalDeathCount desc

--Global numbers 

Select  SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths,SUM(cast(new_deaths as int))/SUM (new_Cases)*100 as DeathPercentage
From [Portfolio project]..CovidDeaths
where continent is null 
--group by date
order by 1,2


--Looking at Total Population vs Vaccinations

Select dea.continent, dea.location,dea.date,dea.Population_density,vac.new_vaccinations, SUM(CONVERT(int,vac.new_vaccinations)) OVER (partition by dea.location Order by dea.location,dea.Date) as Peoplevaccinated
From [Portfolio project]..CovidDeaths dea
join [Portfolio project]..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3

with PopvsVac (continent,location,date,Population_density,new_vaccinations,Peoplevaccinated)

as 
(
Select dea.continent, dea.location,dea.date,dea.Population_density,vac.new_vaccinations, SUM(CONVERT(int,vac.new_vaccinations)) OVER (partition by dea.location Order by dea.location,dea.Date) as Peoplevaccinated
From [Portfolio project]..CovidDeaths dea
join [Portfolio project]..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select * , (Peoplevaccinated/Population_density)*100
From PopvsVac


--Temp Table


DROP TABLE if exists #Percentageofthepopulationvaccinated

Create Table #Percentageofthepopulationvaccinated

(
Continent nvarchar(255),
location nvarchar(255),
Date datetime,
Population_density numeric, 
new_vaccinations numeric,
Peoplevaccinated numeric,
)

Insert into  #Percentageofthepopulationvaccinated


Select dea.continent, dea.location,dea.date,dea.Population_density,vac.new_vaccinations, SUM(CONVERT(int,vac.new_vaccinations)) OVER (partition by dea.location Order by dea.location,dea.Date) as Peoplevaccinated
From [Portfolio project]..CovidDeaths dea
join [Portfolio project]..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

Select * , (Peoplevaccinated/Population_density)*100
From  #Percentageofthepopulationvaccinated


-- Creating View to store data for later visualizations 

create view Percentageofthepopulationvaccinated as 

Select dea.continent, dea.location,dea.date,dea.Population_density,vac.new_vaccinations, SUM(CONVERT(int,vac.new_vaccinations)) OVER (partition by dea.location Order by dea.location,dea.Date) as Peoplevaccinated
From [Portfolio project]..CovidDeaths dea
join [Portfolio project]..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3


select * 
From Percentageofthepopulationvaccinated





















