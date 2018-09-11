% Don't forget to 'pkg load statistics'
% You might need to install it first using 'pkg install statistics -forge' .

function predict() 
    f = "../data/classifiers.csv";
    classifiers = dlmread(f, ",", 0, 1); % ignore classifier number - load them in order

    f = "../data/sensor_readings_random.csv";
    readings = dlmread(f, ",", 1, 0);

	tests = 100;
	success = 0;
	readings_rnd = randsample(length(readings), tests);
	for t_idx = readings_rnd
		x = readings(t_idx, 1:3);
		face_real = readings(t_idx, 4);
		[yaw, pitch] = xyz_to_yaw_pitch(x(1), x(2), x(3));

		for face = 1:12
			theta = classifiers(face, 1:1);
			b = classifiers(face, 2:5);
			p(face) = compute([yaw pitch yaw^2 pitch^2], theta, b);
		endfor
		[prob, face_predicted] = max(p);
		if face_predicted == face_real
			success++;
		endif
    endfor
	printf("Success: %3.2f%%\n\n", 100.0  * success/tests);
endfunction

function [yaw, pitch] = xyz_to_yaw_pitch(x, y, z)
    yaw = atand(y/x);
    pitch = atand(z/sqrt(x^2+y^2));
endfunction

function p = compute (x, theta, b)
	xb = b*x';
    p = 1/(1+exp(theta-xb));
endfunction
