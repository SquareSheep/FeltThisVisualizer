abstract class Mob {
	boolean finished = false;

	
	abstract void update();

	abstract void render();
}


class TextBox extends Mob {
	String string = "";
	Point p;
	SpringValue ang = new SpringValue(0);
	AColor fillStyle = new AColor(255,255,255,255);
	AColor strokeStyle = new AColor(255,255,255,255);
	int timeEnd;

	TextBox(String string, Point p) {
		this.string = string;
		this.p = p.copy();
	}

	TextBox(String string, float x, float y, float z) {
		this.string = string;
		this.p = new Point(x, y, z);
	}

	void update() {
		p.update();
		ang.update();
	}

	void render() {
		push();
		fillStyle.fillStyle();
		strokeStyle.strokeStyle();
		translate(p.p.x, p.p.y);
		rotate(ang.x);
		text(string, 0,0);
		pop();
	}
}
interface FuncInterface {
	void boxes(Box3d box);
}

class Tunnel extends Mob {

	Point p;
	Point ang;
	Point w;
	ArrayList<Ring> rings = new ArrayList<Ring>();

	Tunnel(Point p, Point w, Point ang, int nofRings) {
		this.p = p;
		this.ang = ang;
		this.w = w;
		for (int i = 0 ; i < nofRings ; i ++) {
			rings.add(new Ring(new Point(0, 0, w.p.z/nofRings*i - w.p.z/2), new Point(w.p.x, w.p.y, w.p.z/nofRings), new Point()));
		}
	}

	void iterateBoxes(FuncInterface func) {
		for (Ring ring : rings) {
			for (Box3d box : ring.boxes) {
				func.boxes(box);
			}
		}
	}

	void update() {
		p.update();
		ang.update();
		for (Ring ring : rings) {
			ring.update();
		}
	}

	void render() {
		push();
		translate(p.p.x,p.p.y,p.p.z);
		rotateX(ang.p.x);
		rotateY(ang.p.y);
		rotateZ(ang.p.z);
		for (Ring ring : rings) {
			ring.render();
		}
		pop();
	}
}

class Ring {
	Point p;
	Point ang;
	Point w;
	SpringValue sca = new SpringValue(1);
	PVector dp; //Default position
	PVector dw;
	PVector dang = new PVector();
	ArrayList<Box3d> boxes = new ArrayList<Box3d>();

	Ring(Point p, Point w, Point ang) {
		this.p = p.copy();
		this.dp = p.p.copy();
		this.ang = ang.copy();
		this.w = w.copy();
		this.dw = w.p.copy();
		for (int i = 0 ; i < w.p.x/w.p.z ; i ++) {
			boxes.add(new Box3d(new Point((float)i*w.p.z-w.p.x/2+w.p.z/2,-w.p.y/2, 0), new Point(w.p.z,w.p.z,w.p.z/10), new Point(PI/2,0,0)));
		}
		for (int i = 0 ; i < w.p.y/w.p.z ; i ++) {
			boxes.add(new Box3d(new Point(w.p.x/2, (float)i*w.p.z-w.p.y/2+w.p.z/2, 0), new Point(w.p.z,w.p.z,w.p.z/10), new Point(0,PI/2,0)));
		}
		for (int i = 0 ; i < w.p.x/w.p.z ; i ++) {
			boxes.add(new Box3d(new Point(-(float)i*w.p.z+w.p.x/2-w.p.z/2, w.p.y/2, 0), new Point(w.p.z,w.p.z,w.p.z/10), new Point(PI/2,0,0)));
		}
		for (int i = 0 ; i < w.p.y/w.p.z ; i ++) {
			boxes.add(new Box3d(new Point(-w.p.x/2, -(float)i*w.p.z+w.p.y/2-w.p.z/2, 0), new Point(w.p.z,w.p.z,w.p.z/10), new Point(0,PI/2,0)));
		}
	}

	void update() {
		p.update();
		ang.update();
		sca.update();
		for (Box3d box : boxes) {
			box.update();
		}
	}

	void render() {
		push();
		translate(p.p.x,p.p.y,p.p.z);
		rotateX(ang.p.x);
		rotateY(ang.p.y);
		rotateZ(ang.p.z);
		scale(sca.x);
		for (Box3d box : boxes) {
			box.render();
		}
		pop();
	}
}

class Box3d extends Mob {
	Point p;
	Point w;
	Point ang;
	PVector dang;
	PVector dp;
	PVector dw;
	AColor fillStyle = new AColor(100,100,100,100);
	AColor strokeStyle = new AColor(100,100,100,100);
	int i;


	Box3d(Point p, Point w) {
		println(p.p.x + " " + p.p.y + " " + p.p.z);
		this.p = p.copy();
		this.w = w;
		this.ang = new Point();
		this.dp = p.p.copy();
		this.dang = new PVector();
		this.dw = w.p.copy();
	}

	Box3d(Point p, Point w, Point ang) {
		this.p = p.copy();
		this.w = w;
		this.ang = ang.copy();
		this.dang = ang.p.copy();
		this.dp = p.p.copy();
		this.dw = w.p.copy();
	}

	void update() {
		p.update();
		w.update();
		ang.update();
		fillStyle.update();
		strokeStyle.update();
	}

	void render() {
		push();
		fillStyle.fillStyle();
		strokeStyle.strokeStyle();
		translate(p.p.x, p.p.y, p.p.z);
		rotateX(ang.p.x);
		rotateY(ang.p.y);
		rotateZ(ang.p.z);
		//translate(0,0,w.p.z/2);
		box(w.p.x, w.p.y, w.p.z);
		pop();
	}
}