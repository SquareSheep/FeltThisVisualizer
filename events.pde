class Event {
	boolean finished = false;
	boolean spawned = false;
	int time;
	int timeEnd;

	void update() {

	}

	void spawn() {

	}
}

class UpdateText extends Event {

	String string;
	PVector p;

	UpdateText(String string, int time) {
		this.time = time;
		this.timeEnd = time + 60;
		this.string = string;
		this.p = new PVector(0,0,0);
	}

	UpdateText(String string, int time, PVector p) {
		this.time = time;
		this.timeEnd = time + 60;
		this.string = string;
		this.p = p;
	}

	void spawn() {
		text1.string = string;
		text1.p.P.add(p);
	}
}

class RestartSong extends Event {
	RestartSong(int time) {
		this.time = time;
		this.timeEnd = time + 200;
	}

	void spawn() {
		println("RESTART");
		seekTo(0);
		mobs.clear();
		for (Event event : events) {
			event.spawned = false;
			event.finished = false;
		}
		spawnTunnel();
	}
}

class StumbleDown119s121 extends Event {
	StumbleDown119s121() {
		time = 79000;
		timeEnd = 82000;
	}

	void spawn() {

	}
}

class WubWub101s119 extends Event {
	WubWub101s119() {
		time = 62100;
		timeEnd = 79000;
	}

	void update() {
		for (Box3d box : boxes) {
			box.fillStyle.r.v += Math.pow(av[box.i]/10,1.5);
		}
	}
}

class SnareWub3 extends SnareWub {
	SnareWub3(int time) {
		super(time);
	}

	void effect() {
		for (int k = 0 ; k < 4 ; k ++) {
			int skip = rings.get(0).boxes.size()*2;
			tick ++;
			for (int i = tick ; i < boxes.size() ; i += skip) {
				set(i);
			}
		}
	}

	void set(int i) {
		Box3d box = boxes.get(i);
		box.fillStyle.setx(255,255,255,255);
		box.w.v.z += zV;
	}
}

class SnareWub2 extends SnareWub {
	SnareWub2(int time) {
		super(time);
	}

	void effect() {
		int skip = rings.get(0).boxes.size()/4;
		tick ++;
		set(boxes.size() - tick);
		for (int i = tick ; i < boxes.size() ; i += skip) {
			set(i);
		}
	}

	void set(int i) {
		Box3d box = boxes.get(i);
		box.fillStyle.setx(255,255,255,255);
		box.w.v.z += zV;
	}
}

class SnareWub1 extends SnareWub {
	SnareWub1(int time) {
		super(time);
	}

	void effect() {
		tick ++;
		Ring ring = rings.get(tick);
		for (Box3d box : ring.boxes) {
			box.fillStyle.setx(255,255,255,255);
			box.w.v.z += zV;
		}
		ring = rings.get(rings.size() - 3 - tick);
		for (Box3d box : ring.boxes) {
			box.fillStyle.setx(255,255,255,255);
			box.w.v.z += zV;
		}
	}
}

abstract class SnareWub extends Event {
	int tick = 0;
	int lifeSpan;
	float zV = width*0.5;
	boolean alreadyWub = false;

	SnareWub(int time) {
		this.time = time - 100;
		this.timeEnd = this.time + (int)mspb;
	}

	void update() {
		lifeSpan ++;
		if (!alreadyWub && lifeSpan % 9.5 <= 1) {
			effect();
			alreadyWub = true;
		} else if (lifeSpan % 9.5 > 3) {
			alreadyWub = false;
		}
	}

	abstract void effect();
}

class BassWub extends Event {
	PVector p;

	BassWub(PVector p, int time) {
		this.time = time;
		this.timeEnd = time + 200;
		this.p = p;
	}

	void spawn() {
		for (Ring ring : rings) {
			ring.p.p = p.copy();
		}
	}

}

class WubWubStart101s102 extends Event {
	WubWubStart101s102() {
		this.time = 62000;
		this.timeEnd = 62500;
	}

	void spawn() {
		for (int i = 0 ; i < rings.size() ; i ++) {
			Ring ring = rings.get(i);
			ring.p.mass = (float)i*i*0.5 + 5;
			ring.p.vMult = 0.7;
		}
		cam.p.P = cam.dp.copy();
		for (Box3d box : boxes) {
			box.fillStyle.setX(0,0,0,255);
			box.strokeStyle.setX(255,255,255,255);
			box.fillStyle.setMass(10);
			box.strokeStyle.setMass(10);
			box.fillStyle.setVMult(0.5);
			box.strokeStyle.setVMult(0.5);
		}
	}
}

class Yell101s101 extends Event {
	Yell101s101() {
		time = 61800;
		timeEnd = 62000;
	}

	void spawn() {
		cam.p.vMult = 0.3;
		cam.p.mass = 5;
		cam.p.P.z = aw;
	}
}

class DrumFlip extends Event {
	int num;
	int num2;

	DrumFlip(int time, int num, int num2) {
		this.time = time;
		this.timeEnd = time + 200;
		this.num = num;
		this.num2 = num2;
	}

	void spawn() {
		Ring ring = rings.get(num);
		ring.ang.vMult = 0.8;
		ring.ang.mass = 20;
		ring.ang.P.x += PI;
		for (Box3d box : ring.boxes) {
			box.fillStyle.setx(255,255,255,255);
		}

		ring = rings.get(num2);
		ring.ang.vMult = 0.8;
		ring.ang.mass = 20;
		ring.ang.P.x += PI;
		for (Box3d box : ring.boxes) {
			box.fillStyle.setx(255,255,255,255);
		}
	}
}

class Silence059s060 extends Event {
	Silence059s060() {
		time = 59500;
		timeEnd = 60000;
	}

	void spawn() {
		for (Ring ring : rings) {
			ring.ang.mass = 60;
			ring.ang.vMult = 0.7;
			ring.ang.p.z = ring.ang.p.z % (2*PI);
			ring.ang.P = ring.dang.copy();
		}
		for (Box3d box : boxes) {
			box.fillStyle.setX(255,100,100,255);
		}
		cam.ang.P.z = cam.dang.z;
	}
}

class LookingFor051s059 extends Event {
	float f = 0.01;
	float a = 0.01;
	LookingFor051s059() {
		time = 51700;
		timeEnd = 59500;
	}

	void spawn() {
		for (int i = 0 ; i < rings.size() ; i ++) {
			Ring ring = rings.get(i);
			ring.ang.vMult = 0.9 - i*0.05;
		}
		for (Box3d box : boxes) {
			box.fillStyle.setMass(5);
			box.fillStyle.setVMult(0.9);
		}
	}

	void update() {
		if (timer.beat) {
			f += 0.003;
			a += 0.001;
			for (int i = 0 ; i < rings.size() ; i ++) {
				Ring ring = rings.get(i);
				ring.ang.P.z += i*0.1 + a;
			}
		}
		for (int i = 0 ; i < rings.size() ; i ++) {
			Ring ring = rings.get(i);
			ring.ang.P.z += a*i + 0.01;
		}
		for (Box3d box : boxes) {
			box.fillStyle.r.X = av[box.i]*175*f + f*2000;
			box.fillStyle.g.X = av[box.i]*55*f + f*2000;
			box.fillStyle.b.X = av[box.i]*80*f + f*2000;
			//box.fillStyle.a.X = av[box.i]*200*f + f*2000;
			box.w.v.z += av[box.i] + f*100;
		}
	}
}

class LookingFor041s051 extends Event {
	int tick;
	float f = 1;
	float v = 0;
	float v2 = 0;
	float a = 0.00002;
	float a2 = 0;

	LookingFor041s051() {
		time = 41500;
		timeEnd = 52000;
	}

	void spawn() {
		text1.string = "";
	}

	void update() {
		v += 0.00001;
		v2 += a2;
		a2 += 0.0000001;
		f += 0.01;
		cam.ang.P.z -= v2;
		for (int i = 0 ; i < rings.size() ; i ++) {
			rings.get(i).ang.P.z += v*(i + 1);
		}
		cam.p.P.z += v*10;
		for (Box3d box : boxes) {
			box.fillStyle.r.X= av[box.i]*0.75*f;
			box.fillStyle.g.X = av[box.i]*0.5*f;
			box.fillStyle.b.X = av[box.i]*0.9*f;
			box.w.v.z += av[box.i];
		}
	}
}

class TakeItZone031s041 extends Event {
	float f = 10;
	TakeItZone031s041() {
		time = 31200;
		timeEnd = 41500;
	}

	void spawn() {
		text1.string = "Cause I can't\ntake it";
		f = 1;
		for (int i = 0 ; i < boxes.size() ; i ++) {
			Box3d box = boxes.get(i);
			box.strokeStyle.setX(255,255,255,255);
			box.strokeStyle.setMass(15);
			box.w.P.z = box.dw.z;
			box.fillStyle.setMass(5);
			box.fillStyle.a.X = 255;
		}
	}

	void update() {
		if (currTime > 35100 && currTime < 35300) text1.string = "Don't wanna";
		if (currTime > 36200 && currTime < 36500) text1.string = "Don't wanna\nbe alone";
		if (currTime > 37200 && currTime < 37300) text1.string = "But I'm not";
		if (currTime > 38200 && currTime < 38400) text1.string = "But I'm not\nin the zone";
		f += 0.015;
		cam.p.P.z += 0.75;
		for (Box3d box : boxes) {
			box.fillStyle.r.X = av[box.i]*0.75*f;
			box.fillStyle.g.X = av[box.i]*0.5*f;
			box.fillStyle.b.X = av[box.i]*0.9*f;
			//box.fillStyle.a.X = av[box.i]*0.9*f;
			box.w.v.z += av[box.i];
		}
	}
}

class Corner026s31 extends Event {
	Corner026s31() {
		time = 25000;
		timeEnd = 31000;
	}

	void spawn() {
		for (int i = 0 ; i < boxes.size() ; i ++) {
			Box3d box = boxes.get(i);
			box.strokeStyle.setX(0,0,0,0);
			box.strokeStyle.setMass(100);
			box.w.P.z = box.dw.z;
			box.fillStyle.setMass(25);
		}
	}

	void update() {
		if (currTime > 27400 && currTime < 27600) text1.string = "Not ready\n";
		if (currTime > 28400 && currTime < 28600) text1.string = "Not ready\nto resume";
		if (currTime > 29800 && currTime < 30000) text1.string = "Cause I can't";
		if (timer.beat && timer.tick % 2 == 1) {
			for (Box3d box : boxes) {
				box.fillStyle.addx(55,55,55,55);
				box.fillStyle.setX(av[box.i]*10, av[box.i]*25,av[box.i]*5,0);
				box.strokeStyle.setX(av[box.i]*10, av[box.i]*25,av[box.i]*5,255);
			}
		}
	}
}

class FindMe021s026 extends Event {
	FindMe021s026() {
		time = 21400;
		timeEnd = 26000;
	}

	void spawn() {
		text1.string = "Find me";
		for (Box3d box : boxes) {
			box.fillStyle.setX(0,0,0,255);
			box.strokeStyle.setX(255,255,255,255);
			box.fillStyle.setMass(100);
			box.w.P.z = box.dw.z;
		}
	}

	void update() {
		if (currTime > 24500 && currTime < 24800) text1.string = "In the corner";
		if (currTime > 25500 && currTime < 26400) text1.string = "In the corner\nof the room";
	}
}

class Violins011s021 extends Event {
	Violins011s021() {
		time = 11000;
		timeEnd = 21500;
	}

	void spawn() {
		for (int i = 0 ; i < boxes.size() ; i ++) {
			Box3d box = boxes.get(i);
			box.i = binCount - 1 - i%binCount;
		}
		cam.p.mass = 100;
	}

	void update() {
		cam.p.P.z -= 1.5;
		for (Box3d box : boxes) {
			box.fillStyle.r.v += av[box.i]*1.25;
			box.fillStyle.g.v += av[box.i]*1;
			box.fillStyle.b.v += av[box.i]*2;
			box.w.P.z = av[box.i]*2;
		}
	}
}

class Flashes000s011 extends Event {
	Flashes000s011() {
		time = 0;
		timeEnd = 11000;
	}

	void spawn() {
		for (int k = 0 ; k < boxes.size() ; k ++) {
			Box3d box = boxes.get(k);
			box.fillStyle.setX(25,0,0,255);
			box.strokeStyle.setX(255,255,255,255);
			box.i = k%binCount;
		}
	}

	void update() {
		for (int i = 0 ; i < boxes.size() ; i ++) {
			Box3d box = boxes.get(i);
			box.fillStyle.r.v += av[box.i]*2;
			box.fillStyle.g.v += av[box.i]*1;
			box.fillStyle.b.v += av[box.i]*1;
			box.w.v.z += av[box.i]*0.01;
		}
		for (int i = 0 ; i < rings.size() ; i ++) {
			Ring ring = rings.get(i);
			ring.sca.v -= av[i*binCount/rings.size()]/3000;
		}
	}
}