import big.data.*;

Place[] listOfCities;
DataSource ds;

void setup(){
 DataSource.initializeProcessing(this);
 ds = DataSource.connectCSV("data/US_Cities_Longitude_Latitude.csv");
 ds.load();
 ds.printUsageString();
 
 //Throws error "{City<?>, State<?>, Latitude<?>, Longitude<?>} not found"
 //Not sure if syntax is wrong or if it does not work due to a bug(??)
 listOfCities = ds.fetchArray("Place", "City", "State", "Latitude", "Longitude");
 
}
