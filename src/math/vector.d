module src.math.vector;

class Vector {

	this() {
		this(0, 0, 0);
	}

	this(double x, double y, double z) {
		data = new double[3];
		data[0] = x;
		data[1] = y;
		data[2] = z;
	}

	@property public void x(double x) {
		data[0] = x;
	}

	@property public void y(double y) {
		data[1] = y;
	}

	@property public void z(double z) {
		data[2] = z;
	}

	@property public double x() {
		return data[0];
	}

	@property public double y() {
		return data[1];
	}

	@property public double z() {
		return data[2];
	}

	ref double opIndex(size_t a) {
		return data[a];
	}

	double[] data;
}