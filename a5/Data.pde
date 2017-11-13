public class Data{

  private int size;
  private DataPoint[] dataPoints;

  public Data(int size){
    this.size = size;
    this.dataPoints = new DataPoint[size];

    for (int i = 0; i < size; i++)
      this.dataPoints[i] = new DataPoint(random(20, 100), false);
    for (int i = 0; i < 2; i++) {
      int idx;
      do {
        idx = int(random(1, size));
        println(idx);
      } while (this.dataPoints[idx].isMarked);
      this.dataPoints[idx].setMarked(true);
    }
  }

  public int size(){
    return this.size;
  }
  
  public DataPoint get(int i) {
    return this.dataPoints[i];
  }
  
  public float getSum() {
    float sum = 0;
    for (int i = 0; i < this.size; i++) sum += this.dataPoints[i].getValue();
    return sum;
  }

  private class DataPoint{
    private float value;
    private boolean isMarked;

    public DataPoint(float value, boolean isMarked){
      this.value = value;
      this.isMarked = isMarked;
    }

    public void setMarked(boolean marked) {
      this.isMarked = marked;
    }

    public boolean isMarked(){
      return this.isMarked;
    }

    public float getValue(){
      return this.value;
    }

  }

}