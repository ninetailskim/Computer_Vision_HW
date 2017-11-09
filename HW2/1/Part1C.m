function RMSE = Part1C(AK,AR,At,Ap3D,Ap2D,str)
    ARt = [AR(1,:) At(1);AR(2,:) At(2);AR(3,:) At(3)];
    AP = AK * ARt;
    Ap3D(:,4) = 1;
    Amake2D = (AP * Ap3D')';
    test = AP * [0;0;0;0];
    test
    Amake2D(:,1) = Amake2D(:,1) ./ Amake2D(:,3);
    Amake2D(:,2) = Amake2D(:,2) ./ Amake2D(:,3);

    A = imread(str);
    figure;
    B = imshow(A);
    error = 0;
    hold on
    for i = 1:108
        plot(Ap2D(i,1),Ap2D(i,2),'yo');
        plot(Amake2D(i,1),Amake2D(i,2),'r*');
        error = error + (Ap2D(i,1) - Amake2D(i,1))^2 + (Ap2D(i,2) - Amake2D(i,2))^2;
    end
    title(['RMS error :' num2str(sqrt(error / 108))]);
    