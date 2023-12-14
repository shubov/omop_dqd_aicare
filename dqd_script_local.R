install.packages("rJava")
install.packages("devtools")
install.packages("DatabaseConnector")
library(rJava)
library(devtools)
library(DatabaseConnector)
devtools::install_github("OHDSI/CommonDataModel")
Sys.setenv("DATABASECONNECTOR_JAR_FOLDER" = "/home/rstudio/db_drivers")
downloadJdbcDrivers("postgresql")
cd <- DatabaseConnector::createConnectionDetails(
  dbms = "postgresql",
  server = "host.docker.internal/vonko_omop",
  user = "vonko",
  password = "1234"
)
devtools::install_github("OHDSI/DataQualityDashboard")
cdmDatabaseSchema <- "vonko_01"
resultsDatabaseSchema <- "vonko_01"
cdmSourceName <- "vonko_01"
cdmVersion <- "5.4"
numThreads <- 3
sqlOnly <- FALSE
sqlOnlyIncrementalInsert <- FALSE
sqlOnlyUnionCount <- 25
outputFolder <- "/home/rstudio/output"
outputFile <- "results.json"
verboseMode <- TRUE
writeToTable <- TRUE
writeTableName <- "dqdashboard_results"
writeToCsv <- TRUE
csvFile <- "csv_output_dqd.csv"
checkLevels <- c("TABLE", "FIELD", "CONCEPT")
checkNames <- c()
tablesToExclude <- c("CONCEPT", "VOCABULARY", "CONCEPT_ANCESTOR", "CONCEPT_RELATIONSHIP", "CONCEPT_CLASS", "CONCEPT_SYNONYM", "RELATIONSHIP", "DOMAIN")
DataQualityDashboard::executeDqChecks(connectionDetails = cd,
                                      cdmDatabaseSchema = cdmDatabaseSchema,
                                      resultsDatabaseSchema = resultsDatabaseSchema,
                                      cdmSourceName = cdmSourceName,
                                      cdmVersion = cdmVersion,
                                      numThreads = numThreads,
                                      sqlOnly = sqlOnly,
                                      sqlOnlyUnionCount = sqlOnlyUnionCount,
                                      sqlOnlyIncrementalInsert = sqlOnlyIncrementalInsert,
                                      outputFolder = outputFolder,
                                      outputFile = outputFile,
                                      verboseMode = verboseMode,
                                      writeToTable = writeToTable,
                                      writeToCsv = writeToCsv,
                                      csvFile = csvFile,
                                      checkLevels = checkLevels,
                                      tablesToExclude = tablesToExclude,
                                      checkNames = checkNames)
DataQualityDashboard::writeJsonResultsToTable(connectionDetails = cd,
                                              resultsDatabaseSchema = resultsDatabaseSchema,
                                              jsonFilePath = jsonFilePath)
jsonFilePath <- "/Users/shubov/Projects/THESIS/vonko-dqd/results.json"
DataQualityDashboard::viewDqDashboard(jsonFilePath)
