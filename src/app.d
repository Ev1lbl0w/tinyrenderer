module src.app;

import src.image.color;
import src.image.ppm;
import src.model.obj;
import src.math.vector;

import core.stdc.stdlib;
import std.stdio;
import std.conv;
import std.math;

PPMImage image;
OBJModel headModel;

int width, height;

void printHelp() {
	writeln("Usage: ./tinyrenderer outputToRender.ppm");
	exit(EXIT_FAILURE);
}

void main(string[] args)
{
	if(args.length < 2) printHelp();
	string path = args[1];
	width = 800;
	height = 800;

	image = new PPMImage(width, height);
	headModel = new OBJModel("assets/african_head.obj");

	render();
	image.save(path);
}

void render() {
	/*line(13, 20, 80, 40, Colors.white);
	line(20, 13, 40, 80, Colors.red);
	line(80, 40, 13, 20, Colors.red);
	/*line(0, 0, 2, 99, Colors.pink);
	line(0, 0, 99, 99, Colors.yellow);
	line(10, 80, 90, 32, Colors.blue);*/
	model(headModel, Colors.white);
}

void line(int x0, int y0, int x1, int y1, Color c) {
	float dots = 1 / sqrt(cast(float)(pow(x1-x0, 2) + pow(y1-y0, 2)));
	for(float t = 0; t < 1; t+= dots) {
		image.setPixel(to!int(x0*(1-t) + x1*t), to!int(y0*(1-t) + y1*t), c);
	}
}

void model(OBJModel model, Color c) {
	for(int face = 0; face < model.faces.length; face++) {
		Vector vertices = model.faces[face];
		for(int i = 0; i < 3; i++) {
			Vector v0Coords = model.vertex[to!int(vertices[i])];
			Vector v1Coords = model.vertex[to!int(vertices[(i+1)%3])];
			int x0 = to!int((v0Coords.x + 1) * width/2);
			int y0 = to!int((v0Coords.y + 1) * width/2);
			int x1 = to!int((v1Coords.x + 1) * height/2);
			int y1 = to!int((v1Coords.y + 1) * height/2);
			line(x0, y0, x1, y1, c);
		}
	}
}