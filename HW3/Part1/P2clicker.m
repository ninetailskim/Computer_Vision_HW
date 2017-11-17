% ·Ù®ðaClicker
function [point2D] = P2clicker(num,image)

    chessboardImage = image ;

    thisWindow = largeDarkFigure();
    imshow(chessboardImage);

    hold on;

    % 12 rows, 9 columns, x y
    point2D = zeros(num,2);

    for rowI = 1 : num
            [ clickX, clickY ] = ginput(1);
            scatter( clickX, clickY, 100, 'lineWidth', 4 );
            drawnow;
            point2D(rowI, : ) = [ clickY, clickX ] ;
    end

    close(thisWindow);
end