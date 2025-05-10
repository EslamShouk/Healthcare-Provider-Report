-----------------------------------------------OVERVIEW-----------------------------------------------------------

-- What is The Total Patients ?
Select  Count(distinct Patient_ID) as "Total Patients" from visits 

-- What is The Total Visits ?
Select  Count(Patient_ID) as "Total Visits" from visits

-- What is The Avg Treatment Cost ?
select avg(Treatment_Cost) as "Avg Treatment Cost" from visits

-- What is The Avg Medication Cost ?
select avg(Medication_Cost) as "Avg Medication Cost" from visits
 

-- What is the percentage of emergency and non-emergency visits?
select Emergency_Visit , concat(count(Emergency_Visit) * 100 / 5000,'%') as "Percentage"
from visits
Group by Emergency_Visit 

-- What is The Gender Distribution ?
select Gender , count(Gender) "Total"
from patients
group by Gender

-- What is The Visit prevalence across disease ?
select D.Diagnosis , count(D.Diagnosis) "Total"
from visits V
join diagnoses D
on V.Diagnosis_ID = D.Diagnosis_ID
Group By D.Diagnosis
order by 2 desc

-- What is The Visit Distribution across Diagnostic ?
select P.[Procedure] , count(P.[Procedure]) "Total"
from visits V
join Procedures P
on P.Procedure_ID = V.Procedure_ID
Group By P.[Procedure]
order by 2 desc

-----------------------------------------------Doctors-----------------------------------------------------------

-- What is The Patient Volume Per Provider ?
select P.Provider_Name , count(P.Provider_Name) "Total"
from visits V
join providers P
on P.Provider_ID = V.Provider_ID
Group By P.Provider_Name
order by 2 desc

-- What is The Average Statisfication Score Per Provider ?
select P.Provider_Name , round(AVG(CAST(V.Patient_Satisfaction_Score AS FLOAT)),2) "Average Statisfication Score"
from visits V
join providers P
on P.Provider_ID = V.Provider_ID
Group By P.Provider_Name
order by 2 desc

-----------------------------------------------Patients-----------------------------------------------------------

-- What is The Average Statisfication Score ?
Select  round(AVG(CAST(Patient_Satisfaction_Score AS FLOAT)),2) as "Average Statisfication Score" from visits 

-- What is The Average Visit Cost ?
Select  avg(Medication_Cost) + avg(Treatment_Cost) as "Average Visit Cost" from visits 

-- What is The Average Insurance Coverage ?
Select  round(avg(Insurance_Coverage),1) as "Average Visit Cost" from visits 

-- What is the percentage of insurance coverage relative to Visits costs ?
Select CONCAT(ROUND((Sum(Insurance_Coverage) / (Sum(Medication_Cost) + Sum(Treatment_Cost))) * 100, 1),'%') 
as "Percentage" FROM visits;

-- What is The Patient Distribution by Room Type ?
Select Room_Type , count(Patient_ID) as "Total" 
from visits
group by Room_Type
order by 2 desc

-- What is The Average Patient Satisfaction by Room Type ?
Select Room_Type
, round(AVG(CAST(Patient_Satisfaction_Score AS FLOAT)),2) as "Average Statisfication Score" 
from visits
group by Room_Type
order by 2 desc

-- What is The Patient Distribution by Department ?
Select D.Department , count(V.Patient_ID) as "Total" 
from visits V
join departments D
on D.Department_ID=V.Department_ID
group by D.Department
order by 2 desc

-- What is The Average Patient Satisfaction by Department ?
Select D.Department
, round(AVG(CAST(V.Patient_Satisfaction_Score AS FLOAT)),2) as "Average Statisfication Score" 
from visits V
join departments D
on D.Department_ID=V.Department_ID
group by D.Department
order by 2 desc

-- What is The Time-Based Patient Visit Trends ?
select Datename(month,Date_of_Visit) "Month" , count(distinct Patient_ID) as "Total Vistis"
from visits
group by Datename(month,Date_of_Visit)
order by 2 desc

-- What is The Visit Distribution by Referral Source and Diagnosis ?
select V.Referral_Source , D.Diagnosis , count(V.Patient_ID) as "Total"
from visits V
join diagnoses D
on D.Diagnosis_ID=V.Diagnosis_ID
group by V.Referral_Source, D.Diagnosis 
order by 1

---------------------------------------------Geographical Patient Analysis---------------------------------------------

-- What is The Leading State by Patient Volume
select Top 1 C.[State] , COUNT(distinct V.Patient_ID) "Total"
from visits V
join patients P 
on P.Patient_ID = V.Patient_ID
join cities C
on C.City_ID=P.City_ID
group by C.[State]
order by 2 desc

-- What is The Average Statisfication Score on Weles ?
Select round(AVG(CAST(V.Patient_Satisfaction_Score AS FLOAT)),2) as "Average Statisfication Score" 
from visits V
join patients P 
on P.Patient_ID = V.Patient_ID
join cities C
on C.City_ID=P.City_ID
where C.[State]= 'Wales'

-- What is The Patient Distribution Across States ?
select C.[State] , COUNT(distinct V.Patient_ID) "Total"
from visits V
join patients P 
on P.Patient_ID = V.Patient_ID
join cities C
on C.City_ID=P.City_ID
group by C.[State]
order by 2 desc

-- What is The Average Patient Satisfaction Across States ?
Select C.[State] , round(AVG(CAST(V.Patient_Satisfaction_Score AS FLOAT)),2) as "Average Statisfication Score" 
from visits V
join patients P 
on P.Patient_ID = V.Patient_ID
join cities C
on C.City_ID=P.City_ID
group by C.[State]
order by 2 desc

-- What is The Patient Distribution Across Cities ?
select C.City , COUNT(distinct V.Patient_ID) "Total"
from visits V
join patients P 
on P.Patient_ID = V.Patient_ID
join cities C
on C.City_ID=P.City_ID
group by C.City
order by 2 desc

-- What is The Average Patient Satisfaction Across Cities ?
Select C.City , round(AVG(CAST(V.Patient_Satisfaction_Score AS FLOAT)),2) as "Average Statisfication Score" 
from visits V
join patients P 
on P.Patient_ID = V.Patient_ID
join cities C
on C.City_ID=P.City_ID
group by C.City
order by 2 desc