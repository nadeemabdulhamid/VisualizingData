import big.data.*;

Park[] listOfParks;
DataSource ds;

void setup(){
  ds.initializeProcessing(this);
  ds = ds.connectCSV("data/US_National_Parks_Coordinates.csv");
  ds.load();
  ds.printUsageString();
}
