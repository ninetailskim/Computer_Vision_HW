strkobe = 'kobeFace.png';
strgasol = 'gasolFace.png';
koberes = drawLBP(strkobe);
gasolres = drawLBP(strgasol);

hist_kobe = getHist(koberes,256);
hist_gasol = getHist(gasolres,256);
hist_kobe = hist_kobe / norm(hist_kobe);
hist_gasol = hist_gasol / norm(hist_gasol);

disp('No Divide:');
res = hist_kobe * hist_gasol'
disp('Divide 2 X 2:');
divide(koberes,gasolres,2,256)
disp('Divide 3 X 3:');
divide(koberes,gasolres,3,256)
disp('Divide 4 X 4:');
divide(koberes,gasolres,4,256)
disp('Divide 9 X 9:');
divide(koberes,gasolres,9,256)
disp('Divide 20 X 20:');
divide(koberes,gasolres,20,256)