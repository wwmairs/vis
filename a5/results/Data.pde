public class Data{

  private int size;
  private DataPoint[] dataPoints;

  public Data(DataPoint[] points){
    this.size       = points.length;
    this.dataPoints = points;

  }

  public int size(){
    return this.size;
  }
  
  public DataPoint get(int i) {
    return this.dataPoints[i];
  }
  
  float maxError() {
    float max = this.meanError();
    for (int i = 0; i < size; i++) {
      if (dataPoints[i].getError() > max) {
        max = dataPoints[i].getError();
      }
    }
    return max;
  }
  
  float minError() {
    float min = this.meanError();
    for (int i = 0; i < size; i++) {
      if (dataPoints[i].getError() < min) {
        min = dataPoints[i].getError();
      }
    }
    return min;
  }
  
  float sumError() {
    float sum = 0;
    for (int i = 0; i < size; i++) {
      sum += dataPoints[i].getError();
    }
    return sum;
  }
  
  float meanError() {
    return this.sumError() / size;
  }
  

}

public class DataPoint{
  private String participantId;
  private int trialId;
  private String chartName;
  private float truePercent;
  private float reportedPercent;
  private float error;

  public DataPoint(String pId, int tId, String cName, float tPercent, float rPercent, float err){
    this.participantId   = pId;
    this.trialId         = tId;
    this.chartName       = cName;
    this.truePercent     = tPercent;
    this.reportedPercent = rPercent;
    this.error           = err;
  }
  
  float getError() {
    return this.error;
  }


}