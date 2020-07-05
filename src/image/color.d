module src.image.color;

enum Colors : Color {
	white = new Color(255, 255, 255),
	black = new Color(0, 0, 0),
	red = new Color(255, 0, 0),
	green = new Color(0, 255, 0),
	blue = new Color(0, 0, 255),
	yellow = new Color(255, 255, 0),
	pink = new Color(255, 0, 255),
	cyan = new Color(0, 255, 255),
	grey = new Color(128, 128, 128),
}

class Color {

	this() {
		this(0, 0, 0);
	}

	this(ubyte r, ubyte g, ubyte b) {
		data = new ubyte[3];
		data[0] = r;
		data[1] = g;
		data[2] = b;
	}

	@property public void r(ubyte r) {
		data[0] = r;
	}

	@property public void g(ubyte g) {
		data[1] = g;
	}

	@property public void b(ubyte b) {
		data[2] = b;
	}

	@property public ubyte r() {
		return data[0];
	}

	@property public ubyte g() {
		return data[1];
	}

	@property public ubyte b() {
		return data[2];
	}

	ref ubyte opIndex(size_t a) {
		return data[a];
	}

	ubyte[] data;
}