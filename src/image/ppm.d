module src.image.ppm;

import src.image.color;
import std.stdio;
import std.conv;
import std.algorithm.mutation;

version(unittest) import aurorafw.unit.assertion;

class PPMImage {
	this(int width, int height) {
		this.width = width;
		this.height = height;
		data = new ubyte[width*height*3];
	}

	public Color getPixel(int x, int y) {
		Color t;
		for(byte b = 0; b < 3; b++) {
			t[b] = data[3*(y * width + x) + b];
		}

		return t;
	}

	public void setPixel(int x, int y, Color c) {
		if(x < 0 || x > width - 1 ||
			y < 0 || y > height - 1)
			return;
			/*throw new Exception("Image: Out of bounds! Tried drawing to" ~
			"(" ~ to!string(x) ~ ", " ~ to!string(y) ~ "), with only size" ~
			"(" ~ to!string(width) ~ ", " ~ to!string(height) ~ ")");*/
		for(byte b = 0; b < 3; b++) {
			data[3*(y * width + x) + b] = c[b];
		}
	}

	public void save(string path) {
		File imageFile = File(path, "w");

		// PPM header
		imageFile.writeln("P3");

		// Width and height
		imageFile.writeln(to!string(width) ~ " " ~ to!string(height));

		// Max value, aka value of "white"
		imageFile.writeln("255");

		for(int h = height - 1; h >= 0; h--) {
			for(int w = 0; w < width; w++) {
				for(int b = 0; b < 3; b++) {
					imageFile.write(to!string(data[3*(h * width + w) + b]) ~ " ");
				}
				imageFile.writeln();
			}
		}

		imageFile.close();
	}

	int width, height;
	ubyte[] data;
}

@("Image: Test PPM generation")
unittest {
	import std.stdio;
	import std.path;
	import std.file;

	string path = buildPath(tempDir(), "img.ppm");

	PPMImage image = new PPMImage(3, 2);

	image.setPixel(0, 0, Colors.yellow);
	image.setPixel(1, 0, Colors.white);
	image.setPixel(2, 0, Colors.black);
	image.setPixel(0, 1, Colors.red);
	image.setPixel(1, 1, Colors.green);
	image.setPixel(2, 1, Colors.blue);

	image.save(path);

	File file = File(path, "r");

	assertEquals(`P3
3 2
255
255 0 0 
0 255 0 
0 0 255 
255 255 0 
255 255 255 
0 0 0 
`, file.rawRead(new char[128]));
}

@("Image: Test empty image")
unittest {
	import std.stdio;
	import std.path;
	import std.file;

	string path = buildPath(tempDir(), "img.ppm");

	PPMImage image = new PPMImage(2, 2);
	image.save(path);

	File file = File(path, "r");

	assertEquals(`P3
2 2
255
0 0 0 
0 0 0 
0 0 0 
0 0 0 
`, file.rawRead(new char[128]));
}