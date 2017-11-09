
import java.sql.ResultSet;

void controlEvent(ControlEvent theEvent) {
   if(interfaceReady){
       if(theEvent.isFrom("checkboxMon") ||
          theEvent.isFrom("checkboxDay")){
          submitQuery();  
       }
   
       if(theEvent.isFrom("Temp") ||
          theEvent.isFrom("Wind") ||
          theEvent.isFrom("Humidity")){
         //submitQuery();
         queryReady = true;
       }
   
       if(theEvent.isFrom("Submit")) {
          submitQuery();
       }
   
       if(theEvent.isFrom("Close")){
          closeAll();
       }
   }
}

void submitQuery(){
  
  // ######################################################################## //
  // Finish this:
  // write down the sql, given the constraints from the interface
  // ######################################################################## //
  
  String monthsQuery = "";
  String daysQuery = "";
  
  for (int i = 0; i < checkboxMon.getArrayValue().length; i++) {
        int n = (int)checkboxMon.getArrayValue()[i];
        if(n != 1){
          if ((i > 0) && (monthsQuery.length() != 0)) {
            monthsQuery += " AND ";
          }
          // if n == 1 means that the box is selected
          // you could use months[i].toLowerCase() to get the lower case of the selected box
          // add to query "Month == " + months[i].toLowerCase() + "OR"
          monthsQuery += "month != '" + months[i].toLowerCase() + "'";
        }
  }

  for (int i = 0; i < checkboxDay.getArrayValue().length; i++) {
        int n = (int)checkboxDay.getArrayValue()[i];
        if(n != 1){
          if ((i > 0) && (daysQuery.length() != 0)) {
            daysQuery += " AND ";
          }
          // if n == 1 means that the box is selected
          // you could use days[i].toLowerCase() to get the lower case of the selected box
          daysQuery += "day != '" + days[i].toLowerCase() + "'";
        }
  }

  float maxTemp = rangeTemp.getHighValue();
  float minTemp = rangeTemp.getLowValue();
  
  float maxHum = rangeHumidity.getHighValue();
  float minHum = rangeHumidity.getLowValue();
 
  float maxWind = rangeWind.getHighValue();
  float minWind = rangeWind.getLowValue(); 

  // ######################################################################## //
  // Finish this sql
  // ######################################################################## //

  // query will look something like
  // SELECT x, y, FROM FORESTFIRE WHERE ...........
  String tempQuery = " (temp BETWEEN '" + minTemp + "' AND '" + maxTemp + "')";
  String humQuery = " AND (humidity BETWEEN '" + minHum + "' AND '" + maxHum + "')";
  String windQuery = " AND (wind BETWEEN '" + minWind + "' AND '" + maxWind + "')";
  if (monthsQuery.length() != 0) {
    monthsQuery = "(" + monthsQuery + ")";
    monthsQuery += " AND";
  }
  if (daysQuery.length() != 0) {
    daysQuery = "(" + daysQuery + ")";
    daysQuery += " AND";
  }
  String sql = "SELECT * FROM forestfire WHERE " + monthsQuery + daysQuery + tempQuery + humQuery + windQuery;
   
  try{
      ResultSet rs = (ResultSet)DBHandler.exeQuery(sql);
      toTable(rs);
  }catch (Exception e){
      println(e.toString());
  }  
}

void toTable(ResultSet rs){
    if(rs == null){
       println("In EventHandler, ResultSet is empty!");
       return;
    }
    int rsSize = -1;
    table.clearRows();
    tableChange = true;
    try{
         rs.beforeFirst();
         int count  = 0;
       while(rs.next()){
         count++;
         TableRow newRow = table.addRow();
         newRow.setInt("id", rs.getInt("id"));

        // ######################################################################## //
        // Finish this:
        // We parse everything else except X and Y for you
        // please finish the part that parsing X and Y to the table
        // ######################################################################## //
        
         newRow.setFloat("X", rs.getFloat("X"));
         newRow.setFloat("Y", rs.getFloat("Y"));
         
         newRow.setString("Month", rs.getString("month"));
         newRow.setString("Day", rs.getString("day"));
         newRow.setFloat("Temp", rs.getFloat("temp"));   
         newRow.setFloat("Humidity", rs.getFloat("humidity"));   
         newRow.setFloat("Wind", rs.getFloat("wind"));  
     }
    }catch (Exception e){
       println(e.toString());
    }finally{
        try{
            rs.close();
        }catch(Exception ex){
            println(ex.toString());
        }
    }
}

void closeAll(){
    DBHandler.closeConnection();
    frame.dispose();
    exit();
}