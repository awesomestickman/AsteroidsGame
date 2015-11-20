//your variable declarations here
//key pressers
boolean leftIsPressed = false;
boolean rightIsPressed = false;
boolean upIsPressed = false;
boolean zIsPressed = false;
boolean rIsPressed = false;
boolean xIsPressed = false;
boolean hyperSpeed=false;

int score=0;
int highScore=0;
int deathTimer=6;

int [] starFieldx = new int[50];
int [] starFieldy = new int[50];
ArrayList<Bullet> bullets=new ArrayList<Bullet>();
ArrayList<Asteroids> aBelt = new ArrayList<Asteroids>();
ArrayList<SpaceShip> ais=new ArrayList<SpaceShip>();
int aiSize=20;
int aSize=10;
//Asteroids [] aBelt = new Asteroids[20];
SpaceShip s;

public void setup() 
{
noFill();
  size(800,500);
  starCreate();
  aCreate();
  aiCreate();
  
   s = new SpaceShip();
   
  //your code here
}
public void draw() 
{
  if(hyperSpeed==false){
  background(0, 0, 0);
}
//stars
aiCycle();
starCycle();
aCycle();
aPopulate();
bulletCycle();
  //spaceship activate
  if(s.dead==false){
  s.show();
  s.move();
  s.checkCollision();
  s.bulletTimer();
}
else{

  deathFlash();
}
scoreDisplay();
 
  //key related stuff
  //rotation
  if(leftIsPressed==true){

    s.rotate(-2);
  }
  if(xIsPressed==true){
    if(s.dead==false){

s.shoot();
}
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  }
  if(zIsPressed==true){

    s.hyperSpace();
    starCreate();
    //delete all as
    aBelt=new ArrayList<Asteroids>();
    aCreate();
     ais=new ArrayList<SpaceShip>();
    aiCreate();
    hyperSpeed=true;
  }
  else if(rIsPressed==true){
if(s.dead==true){
    s.hyperSpace();
    starCreate();
    //delete all as
    aBelt=new ArrayList<Asteroids>();
    aCreate();
    ais=new ArrayList<SpaceShip>();
    aiCreate();
    hyperSpeed=false;
    s.dead=false;
    score=0;
    bullets=new ArrayList<Bullet>();
  
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
class Bullet extends Floater
{
  protected boolean dead;
     protected int deathCounter;
     protected SpaceShip mother;
public Bullet(double cx, double cy, double dx, double dy, double d, SpaceShip m){
    
    deathTimer=0;
      dead=false;
    corners=3;  //the number of corners, a triangular floater has 3   
      xCorners=new int[corners];
      yCorners=new int[corners];
      xCorners[0]=0;
      xCorners[1]=1;
      xCorners[2]=2;
       
      yCorners[0]=3;
      yCorners[1]=-1;
      yCorners[2]=-1;
      
      myColor=color(51,255,51);   
      myCenterX=cx;
       myCenterY=cy; //holds center coordinates   
      myDirectionX=dx;
       myDirectionY=dy; //holds x and y coordinates of the vector for direction of travel   
      myPointDirection=d;
      accelerate(2);
      mother=m;
  }
  public void deathTimer(){
deathCounter+=1;
if(deathCounter>100){

  dead=true;
}
 



  }
  public void checkCollision(){
    for(int i =0;i<aBelt.size();i++){
    if(myCenterY<aBelt.get(i).myCenterY+10&&myCenterY>aBelt.get(i).myCenterY-10&&myCenterX<aBelt.get(i).myCenterX+10&&myCenterX>aBelt.get(i).myCenterX-10){
     aBelt.remove(i);
     i--;

    }
    }
    if(s!=mother){
    if(myCenterY<s.myCenterY+5&&myCenterY>s.myCenterY-5&&myCenterX<s.myCenterX+5&&myCenterX>s.myCenterX-5){
     s.dead=true;

    }
  }
   for(int i =0;i<ais.size();i++){
    if (mother!=ais.get(i)){
    if(myCenterY<ais.get(i).myCenterY+10&&myCenterY>ais.get(i).myCenterY-10&&myCenterX<ais.get(i).myCenterX+10&&myCenterX>ais.get(i).myCenterX-10){
     ais.remove(i);
     
     i--;

    }
    }
  }
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
 class Asteroids extends Floater
   {
  private int rotSpeed;
  private boolean dead;

  public Asteroids(){
    dead=false;
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
     protected int bulletCounter;
    public SpaceShip(){
      bulletCounter=0;
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
      myCenterX=(int)(Math.random()*800);
       myCenterY=(int)(Math.random()*500); //holds center coordinates   
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
    public void bulletTimer(){
      bulletCounter++;

    }
     public void shoot(){
      if(bulletCounter>5){
          bulletCounter=0;

          bullets.add(new Bullet(s.myCenterX,s.myCenterY,s.myDirectionX,s.myDirectionY,s.myPointDirection,s));

      }

    }
  public void checkCollision(){
    for(int i =0;i<aBelt.size();i++){
    if(myCenterY<aBelt.get(i).myCenterY+10&&myCenterY>aBelt.get(i).myCenterY-10&&myCenterX<aBelt.get(i).myCenterX+10&&myCenterX>aBelt.get(i).myCenterX-10){
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
    //fill(myColor);   
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
  else if(keyCode==88)
  {
    xIsPressed = true;
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
  else if(keyCode==88)
  {
    xIsPressed = false;
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
for(int i =0;i<aSize;i++){
aBelt.add(new Asteroids());//=new Asteroids();
  
}

}
public void aiCreate(){
for(int i =0;i<aiSize;i++){
ais.add(new SpaceShip());//=new Asteroids();
  
}

}
public void aiCycle(){
for(int i =0;i<ais.size();i++){

if(ais.get(i).dead==true){
  ais.remove(i);
  i--;
 }
 else{
  ais.get(i).move();
  ais.get(i).show();
   ais.get(i).checkCollision();
 }


}

}
public void aPopulate(){
if(aBelt.size()<aSize){
Asteroids newAsteroid=new Asteroids();
newAsteroid.myCenterX=0;
newAsteroid.myCenterY=0;
aBelt.add(newAsteroid);

}

}
public void aCycle(){
for(int i =0;i<aBelt.size();i++){

 
  aBelt.get(i).move();
  aBelt.get(i).show();

}

}

public void deathFlash(){
if(deathTimer>3){
fill(s.myColor);   
stroke(s.myColor);  
text("You Have Died!", 380, 200);
text("Press R to insert coin.", 373, 220);
noFill();
}
deathTimer++;
if(deathTimer>16){
  deathTimer=-8;
}


}
public void scoreDisplay(){
fill(s.myColor);   
stroke(s.myColor); 
if(s.dead==false){
score++;
text("score: "+score, 50, 50);
text("highscore: "+highScore, 50, 80);

}
else if(deathTimer>3){

text("score: "+score, 50, 50);
text("highscore: "+highScore, 50, 80);



}
if(score>highScore){

  highScore=score;
  text("new highscore!!! ", 50, 100);
}
noFill();
}



public void bulletCycle(){
for(int i =0;i<bullets.size();i++){

 Bullet currentBullet=bullets.get(i);
 if(currentBullet.dead==false){
  currentBullet.move();
  currentBullet.show();
  currentBullet.deathTimer();
  currentBullet.checkCollision();
}
else{
  bullets.remove(i);
  i--;
}
System.out.println(bullets.size());
}
}