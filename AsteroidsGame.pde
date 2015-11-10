//your variable declarations here
//key pressers
boolean leftIsPressed = false;
boolean rightIsPressed = false;
boolean upIsPressed = false;
boolean zIsPressed = false;
boolean rIsPressed = false;
boolean hyperSpeed=false;

int deathTimer=6;

int [] starFieldx = new int[50];
int [] starFieldy = new int[50];

Asteroids [] aBelt = new Asteroids[10];
SpaceShip s;

public void setup() 
{

  size(800,500);
  starCreate();
  aCreate();
  
   s = new SpaceShip();
   
  //your code here
}
public void draw() 
{
  if(hyperSpeed==false){
  background(0, 0, 0);
}
//stars
starCycle();
aCycle();
  //spaceship activate
  if(s.dead==false){
  s.show();
  s.move();
  s.checkCollision();
}
else{

  deathFlash();
}
 
  //key related stuff
  //rotation
  if(leftIsPressed==true){

    s.rotate(-2);
  }
  if(zIsPressed==true){

    s.hyperSpace();
    starCreate();
    aCreate();
    hyperSpeed=true;
  }
  if(rIsPressed==true){
if(s.dead==true){
    s.hyperSpace();
    starCreate();
    aCreate();
    hyperSpeed=false;
    s.dead=false;
    }
  }
  else{
 hyperSpeed=false;
  }
  if(rightIsPressed==true){

    s.rotate(2);
  }
  if(upIsPressed==true){

    s.accelerate(0.1);
  }
}
 class Asteroids extends Floater
   {
  private int rotSpeed;

  public Asteroids(){
    rotSpeed=(int)(Math.random()*10);
    corners=5;  //the number of corners, a triangular floater has 3   
      xCorners=new int[corners];
      yCorners=new int[corners];
      xCorners[0]=0;
      xCorners[1]=12;
      xCorners[2]=8;
       xCorners[3]=-8;
        xCorners[4]=-12;
      yCorners[0]=9;
      yCorners[1]=7;
      yCorners[2]=-7;
      yCorners[3]=-7;
        yCorners[4]=7;
      myColor=color(51,255,51);   
      myCenterX=(int)(Math.random()*800);
       myCenterY=(int)(Math.random()*500); //holds center coordinates   
      myDirectionX=(int)(Math.random()*6)-3;
       myDirectionY=(int)(Math.random()*6)-3; //holds x and y coordinates of the vector for direction of travel   
      myPointDirection=0;
  }

  public void move(){
rotate(rotSpeed);
  super.move();
  }
  public int getX(){return (int)myCenterX;} 
    public void setX(int x){myCenterX=x;}
    public void setY(int y){myCenterY=y;}   
    public int getY(){return (int)myCenterY;}   
    public void setDirectionX(double x){myDirectionX=x;}   
    public double getDirectionX(){return (double)myDirectionX;}   
    public void setDirectionY(double y){myDirectionY=y;}   
    public double getDirectionY(){return (double)myDirectionY;}   
    public void setPointDirection(int degrees){myPointDirection=degrees;}   
    public double getPointDirection(){return (double)myPointDirection;} 

}
class SpaceShip extends Floater  
{   
    //your code here
     protected boolean dead;
    public SpaceShip(){
      dead=false;
      corners=3;  //the number of corners, a triangular floater has 3   
      xCorners=new int[corners];
      yCorners=new int[corners];
      xCorners[0]=-8;
      xCorners[1]=8;
      xCorners[2]=-8;
      yCorners[0]=-4;
      yCorners[1]=0;
      yCorners[2]=4;
      myColor=color(51,255,51);   
      myCenterX=250;
       myCenterY=250; //holds center coordinates   
      myDirectionX=0;
       myDirectionY=0; //holds x and y coordinates of the vector for direction of travel   
      myPointDirection=0;
    }
    public int getX(){return (int)myCenterX;} 
    public void setX(int x){myCenterX=x;}
    public void setY(int y){myCenterY=y;}   
    public int getY(){return (int)myCenterY;}   
    public void setDirectionX(double x){myDirectionX=x;}   
    public double getDirectionX(){return (double)myDirectionX;}   
    public void setDirectionY(double y){myDirectionY=y;}   
    public double getDirectionY(){return (double)myDirectionY;}   
    public void setPointDirection(int degrees){myPointDirection=degrees;}   
    public double getPointDirection(){return (double)myPointDirection;}  

    public void hyperSpace(){
      myCenterX=(Math.random()*600)+50;
      myCenterY=(Math.random()*400)+50;
      myPointDirection=(Math.random()*360);
      myDirectionY=0;
      myDirectionX=0;

    }
  public void checkCollision(){
    for(int i =0;i<aBelt.length;i++){
    if(s.myCenterY<aBelt[i].myCenterY+10&&s.myCenterY>aBelt[i].myCenterY-10&&s.myCenterX<aBelt[i].myCenterX+10&&s.myCenterX>aBelt[i].myCenterX-10){
     dead=true;
     

    }

 
    

    }
  }
}
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees     
  abstract public int getX();  
  abstract public void setX(int x); 
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 
void keyPressed()
{
  if(keyCode==37)
  {
    leftIsPressed = true;
  }
   else if(keyCode==38)
  {
    upIsPressed = true;
  }
  else if(keyCode==82)
  {
    rIsPressed = true;
  }
  else if(keyCode==90)
  {
    zIsPressed = true;
  }
  else if (keyCode == 39)
  {
    rightIsPressed = true;
  }
}
void keyReleased()
{
  if(keyCode==37)
  {
    leftIsPressed = false;
  }
  else if (keyCode == 39)
  {
    rightIsPressed = false;
  }
  else if(keyCode==82)
  {
    rIsPressed = false;
  }
  else if  (keyCode==38)
  {
    upIsPressed = false;
  }
  else if(keyCode==90)
  {
    zIsPressed = false;
  }
}

public void starCreate(){
for(int i =0;i<starFieldx.length;i++){
starFieldx[i]=(int)(Math.random()*800);
starFieldy[i]=(int)(Math.random()*500);
  
}

}
public void starCycle(){
for(int i =0;i<starFieldx.length;i++){

 
  ellipse(starFieldx[i],starFieldy[i],1,1);
}

}

public void aCreate(){
for(int i =0;i<aBelt.length;i++){
aBelt[i]=new Asteroids();
  
}

}
public void aCycle(){
for(int i =0;i<aBelt.length;i++){

 
  aBelt[i].move();
  aBelt[i].show();

}

}

public void deathFlash(){
if(deathTimer>3){

text("You Have Died!", 400, 200);
text("Press R to insert coin.", 394, 220);

}
deathTimer++;
if(deathTimer>16){
  deathTimer=-8;
}


}
