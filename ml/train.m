% Don't forget to 'pkg load statistics'
% You might need to install it first using 'pkg install statistics -forge' .

function train ()
    f = "../data/sensor_readings_random.csv";
    data_raw = dlmread(f, ",", 1, 0);

    for face = 1:12
      Y = data_raw(:,4) == face;
      X = data_raw(:, 1:3);
      D = horzcat(X, Y);	
      train_classifier(face, D);
    endfor
endfunction

function [yaw, pitch] = xyz_to_yaw_pitch(x, y, z)
    yaw = atand(y/x);
    pitch = atand(z/sqrt(x^2+y^2));
endfunction

function plot_xy(X, Y)
	figure;
	hold on;
	trues_idx = find(Y==1);
	trues = X(trues_idx,:);
	plot(trues(:,1), trues(:,2), "gx");

	negs_idx = find(Y==0);
	negs_idx_short = negs_idx(randsample(length(negs_idx), 170),:);
	negs = X(negs_idx_short,:);
	plot(negs(:,1), negs(:,2), "ro");
	hold off % release figure
endfunction

function train_classifier ( face, data )
    X = data(:,1:3);
    [yaw, pitch] = arrayfun(@xyz_to_yaw_pitch, X(:,1), X(:,2), X(:,3));
    Y = data(:,4);
    % uncomment to see plot of how the data is distributed
	% plot_xy(horzcat(yaw, pitch),Y); 
	X=horzcat(yaw, pitch, yaw.^2, pitch.^2);

    [theta, b] = logistic_regression(Y, X, 0); # change 0 to 1 to get the training details
    printf("%d, %f, %f, %f, %f, %f\n", face, theta, b(1), b(2), b(3), b(4))
endfunction
