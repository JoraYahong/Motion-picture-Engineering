close all
clear

hula_47 = imread('Hula.00047.tiff','tif');
hula_48 = imread('Hula.00048.tiff','tif');
hula_49 = imread('Hula.00049.tiff','tif');

hula_motion = imread('Hula.Motion.0048.tiff', 'tif');
%hula_motion(:, :, 1) = flipud(hula_motion(:, :, 1));
%hula_motion(:, :, 2) = flipud(hula_motion(:, :, 2));
%hula_motion(:, :, 3) = flipud(hula_motion(:, :, 3));

[rows cols chan] = size(hula_48);
sx = (1 : cols);
sy = (1 : rows);

sx = (800 : 1400);
sy = (300 : 600);

sy = 350 : 450;
sx = 1040 : 1200;

figure(2); 
image(hula_49(sy, sx ,:));
title('Frame 49');
%figure('Name','Frame 49','NumberTitle','off')
%set(gca, 'Position', [0.01 0.01 0.98 0.98]);
axis off;
shg

figure(1);
%figure('Name','Frame 48','NumberTitle','off')
image(sx, sy, hula_48(sy, sx, :));
title('Frame 48');
%set(gca, 'Position', [0.01 0.01 0.98 0.98]);
axis off;
shg;
hold on;
vy = sy(1 : 8 : end);
vx = sx(1 : 8 : end);
VX = ones(length(vy), 1) * vx;
VY = vy' * ones(1, length(vx));
dx = hula_motion(vy, vx, 1);
dy = -hula_motion(vy, vx, 2);
adx = hula_motion(: ,:, 1);
ady = -hula_motion(:, :, 2);

quiver(VX, VY, dx, dy, 'r-');

% make up a grid for interpolation
X = ones(rows, 1) * (1 : cols);
Y = (1 : rows)' * ones(1, cols);

mc_h49 = double(hula_49);
for chan = 1 : 3
  img = double(hula_49(:, :, chan));
  mc_fwd = interp2(X, Y, img, X+adx, Y+ady);
  mc_h49(:, :, chan) = double(mc_fwd);
end;

figure(3);
image((mc_h49(sy, sx, :)/65535));
title('MC Frame 49')
%set(gca, 'Position', [0.01 0.01 0.98 0.98]);
axis off;

figure(4);
mc_error = mc_h49(sy, sx, 2) - double(hula_48(sy, sx, 2));
image((mc_error * 255 / 65535) + 128);
colormap(gray(256));
title('Motion compensated frame difference')
%set(gca, 'Position', [0.01 0.01 0.98 0.98]);
axis off;

figure(5);
non_mcFD = double(hula_49(sy, sx, 2)) - double(hula_48(sy, sx, 2));
image((non_mcFD * 255 / 65535) + 128);
colormap(gray(256));
title('non-mc frame difference')
%set(gca, 'Position', [0.01 0.01 0.98 0.98]);
axis off;

