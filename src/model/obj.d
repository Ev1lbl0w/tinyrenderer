module src.model.obj;

version(unittest) import aurorafw.unit.assertion;

import std.algorithm;
import std.container.array;
import std.stdio;
import std.string;
import std.conv;

import src.math.vector;

class OBJModel {

	this(string path) {
		File objFile = File(path, "r");
		foreach(line; objFile.byLine()) {
			if(line.startsWith("v ")) {
				string vertexLine = to!string(line.chompPrefix("v "));
				Vector v = new Vector();
				int i = 0;
				foreach(string subtext; vertexLine.split(" ")) {
					v[i++] = to!double(subtext);
				}
				vertex.insertBack(v);
			} else if(line.startsWith("f ")) {
				string faceLine = to!string(line.chompPrefix("f "));
				Vector v = new Vector();
				int i = 0;
				foreach(string subtext; faceLine.split(" ")) {
					v[i++] = to!double(subtext[0..subtext.countUntil("/")]) - 1;
				}
				faces.insertBack(v);
			}
		}
	}

	Array!Vector vertex;
	Array!Vector faces;
}

@("Object: Test parsing of simple OBJ model")
unittest {
	import std.stdio;
	import std.path;
	import std.file;

	string path = buildPath(tempDir(), "model.obj");
	File file = File(path, "w");
	file.writeln(`v 0.0123 -0.324 0.003
v 0.774 0.3284 -0.000005
v 0.714 -0.99999 0.314159
f 1/x/x 3/x/x 2/x/x`);

	file.flush();

	OBJModel model = new OBJModel(path);

	assertEquals(model.vertex[0].x, 0.0123);
	assertEquals(model.vertex[2].y, -0.99999);
	assertEquals(model.faces[0].x, 0);
	assertEquals(model.faces[0].z, 1);
}