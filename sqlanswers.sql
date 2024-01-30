use gptmodels;

-- Q.1. What are the average scores for each capability on both the Gemini Ultra and GPT-4 models?
select c.CapabilityName as name, 
round(avg(b.ScoreGemini), 2) as avg_gemini, 
round(avg(b.ScoreGPT4), 2) as avg_gpt4model
from capabilities c join benchmarks b on c.CapabilityID = b.CapabilityID 
group by name;

-- Q.2. Which benchmarks does Gemini Ultra outperform GPT-4 in terms of scores?
select
	b.BenchmarkName as benchmark, 
    c.CapabilityName as capability 
from capabilities c join benchmarks b on c.CapabilityID = b.CapabilityID 
where b.ScoreGemini > b.ScoreGPT4 and b.ScoreGPT4 is not null;

-- Q.3. What are the highest scores achieved by Gemini Ultra and GPT-4 for each benchmark in the Image capability?
select 
	b.BenchmarkName as benchmark, 
    c.CapabilityName as capability, 
    max(b.ScoreGemini) as max_gemini, 
    max(b.ScoreGPT4) as max_gpt4 
from capabilities c join benchmarks b on c.CapabilityID = b.CapabilityID 
group by benchmark, capability 
having capability = 'Image' 
order by max_gemini;

-- Q.4. Calculate the percentage improvement of Gemini Ultra over GPT-4 for each benchmark?
select 
	BenchmarkName as benchmark,
	round((ScoreGemini - ScoreGPT4) * 100/ScoreGPT4, 2) as improvePercentage
from benchmarks
where ScoreGPT4 is not null
order by improvePercentage;

-- Q.5. Retrieve the benchmarks where both models scored above the average for their respective models?
select BenchmarkName, ScoreGemini, ScoreGPT4 from benchmarks
where ScoreGemini > (select round(avg(ScoreGemini), 2) from benchmarks where ScoreGemini is not null)
and ScoreGPT4 > (select round(avg(ScoreGPT4), 2) from benchmarks where ScoreGPT4 is not null);

-- Q.6. Which benchmarks show that Gemini Ultra is expected to outperform GPT-4 based on the next score?
select
	b.BenchmarkName as benchmark, 
    c.CapabilityName as capability,
    b.ScoreGemini as nextScoreGemini,
    b.ScoreGPT4 as nextScoreGPT4
from capabilities c join benchmarks b on c.CapabilityID = b.CapabilityID 
where b.ScoreGemini > b.ScoreGPT4 and b.ScoreGPT4 is not null;

-- Q.7. Classify benchmarks into performance categories based on score ranges?
select 
	BenchmarkName, Description,
	CASE 
		WHEN ScoreGemini >= 90 THEN 'Excellent'
		WHEN ScoreGemini >= 80 AND ScoreGemini < 90 THEN 'Good'
		WHEN ScoreGemini >= 70 AND ScoreGemini < 80 THEN 'Average'
		WHEN ScoreGemini >= 60 AND ScoreGemini < 70 THEN 'Below Average'
        WHEN ScoreGemini < 60 THEN 'Poor'
        ELSE 'N/A'
    END AS performanceGemini,
    CASE 
		WHEN ScoreGPT4 >= 90 THEN 'Excellent'
		WHEN ScoreGPT4 >= 80 AND ScoreGPT4 < 90 THEN 'Good'
		WHEN ScoreGPT4 >= 70 AND ScoreGPT4 < 80 THEN 'Average'
		WHEN ScoreGPT4 >= 60 AND ScoreGPT4 < 70 THEN 'Below Average'
        WHEN ScoreGPT4 < 60 THEN 'Poor'
        ELSE 'N/A'
    END AS performanceGpt4 from benchmarks;
    
-- Q.8. Retrieve the rankings for each capability based on Gemini Ultra scores?
select 
b.BenchmarkName as benchmark,
c.CapabilityName as capability, 
b.ScoreGemini,
rank() over (PARTITION by capability ORDER BY b.ScoreGemini) as GeminiUltraRank
from capabilities c join benchmarks b on c.CapabilityID = b.CapabilityID
where b.ScoreGemini IS NOT NULL
GROUP BY capability, GeminiUltraRank;

-- Q.9. Convert the Capability and Benchmark names to uppercase?
SELECT
upper(b.BenchmarkName) as benchmark,
upper(c.CapabilityName) as capability
from capabilities c join benchmarks b on c.CapabilityID = b.CapabilityID;

-- Q.10. Can you provide the benchmarks along with their descriptions in a concatenated format?
select distinct CONCAT(BenchmarkName, " - ", Description) as BenchmarkWithDesc from benchmarks;