# Harbinger-Health
This is a repository hosting template code for the data ingestion processes for a project with Harbinger health where the organization will be taking there collected healthcare (HL7) and clinical data from.

# Harbinger Health - Clinical Data to OMOP CDM Pipeline

This project supports the ingestion and transformation of clinical data from Harbinger Health’s L7 PostgreSQL system into the OMOP Common Data Model (CDM) using Apache Airflow.

## 📁 Project Structure

- `dags/`: Airflow DAG scripts
- `notebooks/`: Jupyter notebooks for development and demo
- `scripts/`: Helper Python scripts for transformation and utilities
- `configs/`: Configuration templates and environment variables
- `resources/`: OMOP schema and external standards
- `docker/`: (Optional) Dockerized setup for local testing
- `tests/`: Unit and integration tests

## 🚀 Getting Started

1. Install dependencies:
    ```bash
    pip install -r requirements.txt
    ```

2. Run Jupyter Notebook:
    ```bash
    jupyter notebook notebooks/l7_to_omop_airflow_pipeline.ipynb
    ```

3. (Optional) Start Airflow with Docker:
    ```bash
    cd docker
    docker-compose up
    ```

## 🔐 Environment Variables

Copy `.env.example` to `.env` and fill in your database credentials.

## 📚 Resources

- [Airflow Docs](https://airflow.apache.org/docs/apache-airflow/stable/)
- [OMOP CDM](https://ohdsi.github.io/CommonDataModel/)

---

### 🛡️ Sample `.gitignore`

```gitignore
*.pyc
__pycache__/
.env
.env.*
*.db
logs/
.airflow/
*.egg-info/
venv/
.envrc

