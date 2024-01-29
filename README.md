# <center>Gemini Vs ChatGPT SQL Project</center>

## Project Overview

The Gemini Vs ChatGPT Database is designed to store and manage information related to different models, their capabilities, and benchmark scores. This documentation provides an overview of the database structure, including tables and their relationships.

## Purpose
The Gemini Vs ChatGPT database serves the following purposes:
- Storing information about various models and their capabilities.
- Tracking benchmark scores achieved by each model for different capabilities.
- Providing a basis for comparison between the Gemini and ChatGPT models in various scenarios.

## Tables

### Models
The `Models` table stores information about different models.

| Column       | Data Type | Description             |
|--------------|-----------|-------------------------|
| ModelID      | INT       | Primary key for the model |
| ModelName    | VARCHAR(255) | Name of the model    |

### Capabilities
The `Capabilities` table stores information about various capabilities.

| Column         | Data Type | Description                   |
|----------------|-----------|-------------------------------|
| CapabilityID   | INT       | Primary key for the capability |
| CapabilityName | VARCHAR(255) | Name of the capability    |

### Benchmarks
The `Benchmarks` table stores benchmark scores for different models and capabilities.

| Column        | Data Type | Description                              |
|---------------|-----------|------------------------------------------|
| BenchmarkID   | INT       | Primary key for the benchmark            |
| ModelID       | INT       | Foreign key referencing `Models.ModelID` |
| CapabilityID  | INT       | Foreign key referencing `Capabilities.CapabilityID` |
| BenchmarkName | VARCHAR(255) | Name of the benchmark               |
| ScoreGemini   | FLOAT     | Benchmark score for Gemini model        |
| ScoreGPT4     | FLOAT     | Benchmark score for ChatGPT model       |
| Description   | TEXT      | Additional description of the benchmark |


## Database Relationships

The database establishes relationships between the Models, Capabilities, and Benchmarks tables:

- The **Benchmarks** table is connected to the **Models** table through the **ModelID** foreign key.
- The **Benchmarks** table is linked to the **Capabilities** table through the **CapabilityID** foreign key.

These relationships ensure that benchmark scores are associated with specific models and their capabilities, providing a structured and relational framework for querying insights.


## Usage
Users can interact with the database to:
- Retrieve information about specific models and their capabilities.
- Query benchmark scores for different capabilities across models.
- Analyze and compare benchmark performance between the Gemini and ChatGPT models.

## Conclusion
The Gemini Vs ChatGPT database facilitates the comparison and analysis of benchmark scores between the Gemini and ChatGPT models across various capabilities. By providing a structured framework for storing and querying data, it enables researchers and practitioners to gain insights into the performance of these models in different contexts.