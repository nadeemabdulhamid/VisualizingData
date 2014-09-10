// Data Source: http://xisbn.worldcat.org

import big.data.*;
import java.util.Scanner;

import big.data.field.FieldToXMLSpec;
import big.data.field.IDataField;
import big.data.util.XML;



public class WorldCat {
  
  public static void main(String[] args) {
  
   Scanner in = new Scanner(System.in);
   String isbn = "9780073376905";  // in.nextLine();
   
//     DataSource ds = DataSource.connect("http://xisbn.worldcat.org/webservices/xid/isbn/" + isbn);
//     ds.set("method", "getMetadata").set("fl", "*").set("format", "xml").load();

   DataSource ds = DataSource.connect("WorldCatSpec.xml").set("isbn", isbn).load();
    ds.printUsageString();

   /*
   IDataField fs = ds.getFieldSpec();
     XML fsxml = fs.apply(new FieldToXMLSpec());
     System.out.println(fsxml.format(2));
   */
   
  
     String title = ds.fetchString("title");
     String author = ds.fetchString("author");
     int year = ds.fetchInt("year");
     
     System.out.println(isbn + ": " + title + ", " + author + ", " + year + ".");
     
     
     
  }
  
}