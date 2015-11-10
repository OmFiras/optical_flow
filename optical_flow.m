% ����������--��Ƶ

clc

clear

close all

% ��ȡ�ļ�����

% videoReader = vision.VideoFileReader('viptraffic.avi','ImageColorSpace','Intensity','VideoOutputDataType','uint8');

videoReader = vision.VideoFileReader('I:\ILSVRC2015\ILSVRC2015 _snippest_train_vali_test\Data\VID\snippets\val\ILSVRC2015_val_00027000.mp4','ImageColorSpace','Intensity','VideoOutputDataType','uint8');

% ����ת������

converter = vision.ImageDataTypeConverter;

% ��������

opticalFlow = vision.OpticalFlow('ReferenceFrameDelay', 1);

opticalFlow.OutputValue = 'Horizontal and vertical components in complex form';

if 0 % ʹ�õ��㷨

opticalFlow.Method = 'Lucas-Kanade';

opticalFlow.NoiseReductionThreshold = 0.001; % Ĭ����0.0039

else

opticalFlow.Method = 'Horn-Schunck';

opticalFlow.Smoothness = 0.5; % Ĭ����1

end

% ��ʾ����

frame = step(videoReader);

figure

subplot(121)

himg = imshow(frame);

subplot(122)

hof = imshow(frame);

% ��ʼ����

while ~isDone(videoReader)

% �õ�һ֡

frame = step(videoReader);

% ��ʽת��

im = step(converter, frame);

% �������

of = step(opticalFlow, im);

% ����ͼת��

ofI = computeColor(real(of), imag(of));

% ��ʾ

set(himg, 'cdata', frame)

set(hof, 'cdata', ofI)

drawnow

end

release(videoReader);

