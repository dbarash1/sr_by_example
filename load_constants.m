%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FUNCTION CONSTANTS AND PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%should we load pre-calculated data?
global LOAD_DATA;
LOAD_DATA = false;
%target scale factor
global SCALE;
SCALE = 2;
%alpha is the inter-pyramid level scale factor.
global ALPHA;
ALPHA = 2^(1/3);
%NN param
global K;
K=3;
%W is patch width.
global W;
W=5;
global PATCH_SIZE;
PATCH_SIZE = W^2;
global STEP;
STEP = floor(W/2);
global BLUR_KERNEL;
W_BLUR = 3;
BLUR_KERNEL = fspecial('gaussian',W_BLUR );
global BLUR;
BLUR = reshape(BLUR_KERNEL',1,W_BLUR*W_BLUR);

global BLUR_DIST;
BLUR_DIST = ones(W)*3;
BLUR_DIST(2:4,2:4) = 2;
BLUR_DIST(3,3) = 1;
BLUR_DIST = reshape(BLUR_DIST',1,W*W);


global NUMCELLS;
NUMCELLS = uint8(2*log(SCALE)/log(ALPHA) + 1);

global MID;
MID = ceil(double(NUMCELLS)/2);

global EPSILON;
EPSILON = exp(-15);

global MIN_WH;
MIN_WH = 2*W;
global MIN_STD;
MIN_STD = 0.1;

global MAX_PREDS;
MAX_PREDS = K*W*W*SCALE;

global DEFAULT_BG_GREYVAL;
DEFAULT_BG_GREYVAL = 0;

global INTERP_METHOD;
INTERP_METHOD = 'cubic';

global INTERP_METHOD_DS;
INTERP_METHOD_DS='bilinear';

global DIST_THRESH_EPS;
DIST_THRESH_EPS = 1;
