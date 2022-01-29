import processing.video.*;
Movie movie;

String moviePath = "mvi.mp4"; // name of your movie file in data folder
int blendMode = SCREEN; // SCREEN or LIGHTEST

String outputDir = "output-" + moviePath.replace(".", "-");
PGraphics canvas;
int frameNum = 0;
int costy=0;
float _scale;
float viewportWidth = 600;
float viewportHeight = 480;

void setup() {
  size(int(viewportWidth), int(viewportHeight));
  scale(_scale);
  background(0);
  movie = new Movie(this, moviePath);
  movie.play();
}

void draw() {
  if(canvas == null && movie.width > 0){ // initialize the stuff
    // force video to display in the space we allow for it
    _scale = min(viewportWidth / movie.width, viewportHeight / movie.height);
    canvas = createGraphics(int(movie.width), int(movie.height));
    canvas.beginDraw(); // populating pixel array
    canvas.background(0);
    canvas.endDraw();
  }else{
    scale(_scale);
  }
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
  costy++;
  if(canvas != null&&costy==10) 
  {renderFrame();
  costy=0;
  }
}

void renderFrame() {
  print("\nrendering1 frame" + frameNum);

  movie.loadPixels();

  if(blendMode == LIGHTEST){

    canvas.beginDraw();
    canvas.blendMode(blendMode);
    canvas.image(movie, 0, 0);
    canvas.endDraw();
 
  }else if(blendMode == SCREEN){
    
    
    // built-in LIGHTEST blend mode slowly fades out the image (it shouldn't), so we are doing this the hard way
  
    for (int i = 0; i < movie.pixels.length; i++) {
      
      color canvasColor = canvas.pixels[i];
      color frameColor = movie.pixels[i];

      int cg = (canvasColor >> 8 ) & 0xff;

if(cg<180){

        canvas.pixels[i] = frameColor;
      } 
  
      
    }
    canvas.updatePixels();
  }

  frameNum++;    
  canvas.save(outputDir + "/" + nfs(frameNum, 6) + ".bmp"); // or .tiff
  image(canvas, 0, 0);
}
