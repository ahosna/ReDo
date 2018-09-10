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

function train_classifier ( face, data )
    X = data(:,1:3);
    Y = data(:,4);
    [theta, beta] = logistic_regression(Y, X, 0); # change 0 to 1 to get the training details
    printf("%d, %f, %f, %f, %f\n", face, theta, beta(1), beta(2), beta(3));
endfunction
