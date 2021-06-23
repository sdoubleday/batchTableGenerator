# batchTableGenerator
Batch table and extraction objects for incremental extraction from SQL tables and views

## Purpose
Tracking incremental extractions from tables or views to staging tables using SQL, where the source object exists in the same database (could be a view with a cross-database reference).

## NOT Purpose
Keeping track of all of the parts of an ETL process.

## Notes
- data types ROWVERSION and TIMESTAMP are converted to [BINARY](8) in the staged data and batch tables
- Version 1 supports ROWVERSION or TIMESTAMP only
- Batch boundaries are exclusive lower (except first batch), inclusive upper.
- Extraction has an open-ended upper bound with the maximum determined ex post facto.
