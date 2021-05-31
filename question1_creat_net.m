%{
程序内容：创建和训练深度学习模型
程序作者：工程技术学院 土木二班 陈宇翔
时间2021/5/18
%}
%%
%{
加载初始参数

%}
trainingSetup = load("/Users/halftwo/Documents/数学建模/D题解答/第一问/training2.mat");
%%
%{
导入数据
%}
imdsTrain = imageDatastore("/Users/halftwo/Documents/B题全部数据/神经网络数据汇总/白天","IncludeSubfolders",true,"LabelSource","foldernames");
[imdsTrain, imdsValidation] = splitEachLabel(imdsTrain,0.7);
% 调整图像大小以匹配网络输入层。
augimdsTrain = augmentedImageDatastore([224 224 3],imdsTrain);
augimdsValidation = augmentedImageDatastore([224 224 3],imdsValidation);
%%
%{
设置训练选项
%}
opts = trainingOptions("sgdm",...
    "ExecutionEnvironment","auto",...
    "InitialLearnRate",0.01,...
    "Shuffle","every-epoch",...
    "Plots","training-progress",...
    "ValidationData",augimdsValidation);
%%
%{
创建层次图
    %}
lgraph = layerGraph();
%%
%{
添加层分支
%}
tempLayers = [
    imageInputLayer([224 224 3],"Name","Input_gpu_0|data_0","Normalization","zscore","Mean",trainingSetup.Input_gpu_0_data_0.Mean,"StandardDeviation",trainingSetup.Input_gpu_0_data_0.StandardDeviation)
    convolution2dLayer([3 3],24,"Name","node_1","Padding",[1 1 1 1],"Stride",[2 2],"Bias",trainingSetup.node_1.Bias,"Weights",trainingSetup.node_1.Weights)
    batchNormalizationLayer("Name","node_2","Offset",trainingSetup.node_2.Offset,"Scale",trainingSetup.node_2.Scale,"TrainedMean",trainingSetup.node_2.TrainedMean,"TrainedVariance",trainingSetup.node_2.TrainedVariance)
    reluLayer("Name","node_3")
    maxPooling2dLayer([3 3],"Name","node_4","Padding",[1 1 1 1],"Stride",[2 2])];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = averagePooling2dLayer([3 3],"Name","node_15","Padding",[1 1 1 1],"Stride",[2 2]);
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    groupedConvolution2dLayer([1 1],28,4,"Name","node_5","Bias",trainingSetup.node_5.Bias,"Weights",trainingSetup.node_5.Weights)
    batchNormalizationLayer("Name","node_6","Offset",trainingSetup.node_6.Offset,"Scale",trainingSetup.node_6.Scale,"TrainedMean",trainingSetup.node_6.TrainedMean,"TrainedVariance",trainingSetup.node_6.TrainedVariance)
    reluLayer("Name","node_7")
    nnet.shufflenet.layer.ChannelShufflingLayer("shuffle_8to10",4)
    groupedConvolution2dLayer([3 3],1,112,"Name","node_11","Padding",[1 1 1 1],"Stride",[2 2],"Bias",trainingSetup.node_11.Bias,"Weights",trainingSetup.node_11.Weights)
    batchNormalizationLayer("Name","node_12","Offset",trainingSetup.node_12.Offset,"Scale",trainingSetup.node_12.Scale,"TrainedMean",trainingSetup.node_12.TrainedMean,"TrainedVariance",trainingSetup.node_12.TrainedVariance)
    groupedConvolution2dLayer([1 1],28,4,"Name","node_13","Bias",trainingSetup.node_13.Bias,"Weights",trainingSetup.node_13.Weights)
    batchNormalizationLayer("Name","node_14","Offset",trainingSetup.node_14.Offset,"Scale",trainingSetup.node_14.Scale,"TrainedMean",trainingSetup.node_14.TrainedMean,"TrainedVariance",trainingSetup.node_14.TrainedVariance)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    depthConcatenationLayer(2,"Name","node_16")
    reluLayer("Name","node_17")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    groupedConvolution2dLayer([1 1],34,4,"Name","node_18","Bias",trainingSetup.node_18.Bias,"Weights",trainingSetup.node_18.Weights)
    batchNormalizationLayer("Name","node_19","Offset",trainingSetup.node_19.Offset,"Scale",trainingSetup.node_19.Scale,"TrainedMean",trainingSetup.node_19.TrainedMean,"TrainedVariance",trainingSetup.node_19.TrainedVariance)
    reluLayer("Name","node_20")
    nnet.shufflenet.layer.ChannelShufflingLayer("shuffle_21to23",4)
    groupedConvolution2dLayer([3 3],1,136,"Name","node_24","Padding",[1 1 1 1],"Bias",trainingSetup.node_24.Bias,"Weights",trainingSetup.node_24.Weights)
    batchNormalizationLayer("Name","node_25","Offset",trainingSetup.node_25.Offset,"Scale",trainingSetup.node_25.Scale,"TrainedMean",trainingSetup.node_25.TrainedMean,"TrainedVariance",trainingSetup.node_25.TrainedVariance)
    groupedConvolution2dLayer([1 1],34,4,"Name","node_26","Bias",trainingSetup.node_26.Bias,"Weights",trainingSetup.node_26.Weights)
    batchNormalizationLayer("Name","node_27","Offset",trainingSetup.node_27.Offset,"Scale",trainingSetup.node_27.Scale,"TrainedMean",trainingSetup.node_27.TrainedMean,"TrainedVariance",trainingSetup.node_27.TrainedVariance)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","node_28")
    reluLayer("Name","node_29")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    groupedConvolution2dLayer([1 1],34,4,"Name","node_30","Bias",trainingSetup.node_30.Bias,"Weights",trainingSetup.node_30.Weights)
    batchNormalizationLayer("Name","node_31","Offset",trainingSetup.node_31.Offset,"Scale",trainingSetup.node_31.Scale,"TrainedMean",trainingSetup.node_31.TrainedMean,"TrainedVariance",trainingSetup.node_31.TrainedVariance)
    reluLayer("Name","node_32")
    nnet.shufflenet.layer.ChannelShufflingLayer("shuffle_33to35",4)
    groupedConvolution2dLayer([3 3],1,136,"Name","node_36","Padding",[1 1 1 1],"Bias",trainingSetup.node_36.Bias,"Weights",trainingSetup.node_36.Weights)
    batchNormalizationLayer("Name","node_37","Offset",trainingSetup.node_37.Offset,"Scale",trainingSetup.node_37.Scale,"TrainedMean",trainingSetup.node_37.TrainedMean,"TrainedVariance",trainingSetup.node_37.TrainedVariance)
    groupedConvolution2dLayer([1 1],34,4,"Name","node_38","Bias",trainingSetup.node_38.Bias,"Weights",trainingSetup.node_38.Weights)
    batchNormalizationLayer("Name","node_39","Offset",trainingSetup.node_39.Offset,"Scale",trainingSetup.node_39.Scale,"TrainedMean",trainingSetup.node_39.TrainedMean,"TrainedVariance",trainingSetup.node_39.TrainedVariance)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","node_40")
    reluLayer("Name","node_41")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    groupedConvolution2dLayer([1 1],34,4,"Name","node_42","Bias",trainingSetup.node_42.Bias,"Weights",trainingSetup.node_42.Weights)
    batchNormalizationLayer("Name","node_43","Offset",trainingSetup.node_43.Offset,"Scale",trainingSetup.node_43.Scale,"TrainedMean",trainingSetup.node_43.TrainedMean,"TrainedVariance",trainingSetup.node_43.TrainedVariance)
    reluLayer("Name","node_44")
    nnet.shufflenet.layer.ChannelShufflingLayer("shuffle_45to47",4)
    groupedConvolution2dLayer([3 3],1,136,"Name","node_48","Padding",[1 1 1 1],"Bias",trainingSetup.node_48.Bias,"Weights",trainingSetup.node_48.Weights)
    batchNormalizationLayer("Name","node_49","Offset",trainingSetup.node_49.Offset,"Scale",trainingSetup.node_49.Scale,"TrainedMean",trainingSetup.node_49.TrainedMean,"TrainedVariance",trainingSetup.node_49.TrainedVariance)
    groupedConvolution2dLayer([1 1],34,4,"Name","node_50","Bias",trainingSetup.node_50.Bias,"Weights",trainingSetup.node_50.Weights)
    batchNormalizationLayer("Name","node_51","Offset",trainingSetup.node_51.Offset,"Scale",trainingSetup.node_51.Scale,"TrainedMean",trainingSetup.node_51.TrainedMean,"TrainedVariance",trainingSetup.node_51.TrainedVariance)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","node_52")
    reluLayer("Name","node_53")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    groupedConvolution2dLayer([1 1],34,4,"Name","node_54","Bias",trainingSetup.node_54.Bias,"Weights",trainingSetup.node_54.Weights)
    batchNormalizationLayer("Name","node_55","Offset",trainingSetup.node_55.Offset,"Scale",trainingSetup.node_55.Scale,"TrainedMean",trainingSetup.node_55.TrainedMean,"TrainedVariance",trainingSetup.node_55.TrainedVariance)
    reluLayer("Name","node_56")
    nnet.shufflenet.layer.ChannelShufflingLayer("shuffle_57to59",4)
    groupedConvolution2dLayer([3 3],1,136,"Name","node_60","Padding",[1 1 1 1],"Stride",[2 2],"Bias",trainingSetup.node_60.Bias,"Weights",trainingSetup.node_60.Weights)
    batchNormalizationLayer("Name","node_61","Offset",trainingSetup.node_61.Offset,"Scale",trainingSetup.node_61.Scale,"TrainedMean",trainingSetup.node_61.TrainedMean,"TrainedVariance",trainingSetup.node_61.TrainedVariance)
    groupedConvolution2dLayer([1 1],34,4,"Name","node_62","Bias",trainingSetup.node_62.Bias,"Weights",trainingSetup.node_62.Weights)
    batchNormalizationLayer("Name","node_63","Offset",trainingSetup.node_63.Offset,"Scale",trainingSetup.node_63.Scale,"TrainedMean",trainingSetup.node_63.TrainedMean,"TrainedVariance",trainingSetup.node_63.TrainedVariance)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = averagePooling2dLayer([3 3],"Name","node_64","Padding",[1 1 1 1],"Stride",[2 2]);
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    depthConcatenationLayer(2,"Name","node_65")
    reluLayer("Name","node_66")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    groupedConvolution2dLayer([1 1],68,4,"Name","node_67","Bias",trainingSetup.node_67.Bias,"Weights",trainingSetup.node_67.Weights)
    batchNormalizationLayer("Name","node_68","Offset",trainingSetup.node_68.Offset,"Scale",trainingSetup.node_68.Scale,"TrainedMean",trainingSetup.node_68.TrainedMean,"TrainedVariance",trainingSetup.node_68.TrainedVariance)
    reluLayer("Name","node_69")
    nnet.shufflenet.layer.ChannelShufflingLayer("shuffle_70to72",4)
    groupedConvolution2dLayer([3 3],1,272,"Name","node_73","Padding",[1 1 1 1],"Bias",trainingSetup.node_73.Bias,"Weights",trainingSetup.node_73.Weights)
    batchNormalizationLayer("Name","node_74","Offset",trainingSetup.node_74.Offset,"Scale",trainingSetup.node_74.Scale,"TrainedMean",trainingSetup.node_74.TrainedMean,"TrainedVariance",trainingSetup.node_74.TrainedVariance)
    groupedConvolution2dLayer([1 1],68,4,"Name","node_75","Bias",trainingSetup.node_75.Bias,"Weights",trainingSetup.node_75.Weights)
    batchNormalizationLayer("Name","node_76","Offset",trainingSetup.node_76.Offset,"Scale",trainingSetup.node_76.Scale,"TrainedMean",trainingSetup.node_76.TrainedMean,"TrainedVariance",trainingSetup.node_76.TrainedVariance)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","node_77")
    reluLayer("Name","node_78")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    groupedConvolution2dLayer([1 1],68,4,"Name","node_79","Bias",trainingSetup.node_79.Bias,"Weights",trainingSetup.node_79.Weights)
    batchNormalizationLayer("Name","node_80","Offset",trainingSetup.node_80.Offset,"Scale",trainingSetup.node_80.Scale,"TrainedMean",trainingSetup.node_80.TrainedMean,"TrainedVariance",trainingSetup.node_80.TrainedVariance)
    reluLayer("Name","node_81")
    nnet.shufflenet.layer.ChannelShufflingLayer("shuffle_82to84",4)
    groupedConvolution2dLayer([3 3],1,272,"Name","node_85","Padding",[1 1 1 1],"Bias",trainingSetup.node_85.Bias,"Weights",trainingSetup.node_85.Weights)
    batchNormalizationLayer("Name","node_86","Offset",trainingSetup.node_86.Offset,"Scale",trainingSetup.node_86.Scale,"TrainedMean",trainingSetup.node_86.TrainedMean,"TrainedVariance",trainingSetup.node_86.TrainedVariance)
    groupedConvolution2dLayer([1 1],68,4,"Name","node_87","Bias",trainingSetup.node_87.Bias,"Weights",trainingSetup.node_87.Weights)
    batchNormalizationLayer("Name","node_88","Offset",trainingSetup.node_88.Offset,"Scale",trainingSetup.node_88.Scale,"TrainedMean",trainingSetup.node_88.TrainedMean,"TrainedVariance",trainingSetup.node_88.TrainedVariance)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","node_89")
    reluLayer("Name","node_90")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    groupedConvolution2dLayer([1 1],68,4,"Name","node_91","Bias",trainingSetup.node_91.Bias,"Weights",trainingSetup.node_91.Weights)
    batchNormalizationLayer("Name","node_92","Offset",trainingSetup.node_92.Offset,"Scale",trainingSetup.node_92.Scale,"TrainedMean",trainingSetup.node_92.TrainedMean,"TrainedVariance",trainingSetup.node_92.TrainedVariance)
    reluLayer("Name","node_93")
    nnet.shufflenet.layer.ChannelShufflingLayer("shuffle_94to96",4)
    groupedConvolution2dLayer([3 3],1,272,"Name","node_97","Padding",[1 1 1 1],"Bias",trainingSetup.node_97.Bias,"Weights",trainingSetup.node_97.Weights)
    batchNormalizationLayer("Name","node_98","Offset",trainingSetup.node_98.Offset,"Scale",trainingSetup.node_98.Scale,"TrainedMean",trainingSetup.node_98.TrainedMean,"TrainedVariance",trainingSetup.node_98.TrainedVariance)
    groupedConvolution2dLayer([1 1],68,4,"Name","node_99","Bias",trainingSetup.node_99.Bias,"Weights",trainingSetup.node_99.Weights)
    batchNormalizationLayer("Name","node_100","Offset",trainingSetup.node_100.Offset,"Scale",trainingSetup.node_100.Scale,"TrainedMean",trainingSetup.node_100.TrainedMean,"TrainedVariance",trainingSetup.node_100.TrainedVariance)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","node_101")
    reluLayer("Name","node_102")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    groupedConvolution2dLayer([1 1],68,4,"Name","node_103","Bias",trainingSetup.node_103.Bias,"Weights",trainingSetup.node_103.Weights)
    batchNormalizationLayer("Name","node_104","Offset",trainingSetup.node_104.Offset,"Scale",trainingSetup.node_104.Scale,"TrainedMean",trainingSetup.node_104.TrainedMean,"TrainedVariance",trainingSetup.node_104.TrainedVariance)
    reluLayer("Name","node_105")
    nnet.shufflenet.layer.ChannelShufflingLayer("shuffle_106to108",4)
    groupedConvolution2dLayer([3 3],1,272,"Name","node_109","Padding",[1 1 1 1],"Bias",trainingSetup.node_109.Bias,"Weights",trainingSetup.node_109.Weights)
    batchNormalizationLayer("Name","node_110","Offset",trainingSetup.node_110.Offset,"Scale",trainingSetup.node_110.Scale,"TrainedMean",trainingSetup.node_110.TrainedMean,"TrainedVariance",trainingSetup.node_110.TrainedVariance)
    groupedConvolution2dLayer([1 1],68,4,"Name","node_111","Bias",trainingSetup.node_111.Bias,"Weights",trainingSetup.node_111.Weights)
    batchNormalizationLayer("Name","node_112","Offset",trainingSetup.node_112.Offset,"Scale",trainingSetup.node_112.Scale,"TrainedMean",trainingSetup.node_112.TrainedMean,"TrainedVariance",trainingSetup.node_112.TrainedVariance)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","node_113")
    reluLayer("Name","node_114")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    groupedConvolution2dLayer([1 1],68,4,"Name","node_115","Bias",trainingSetup.node_115.Bias,"Weights",trainingSetup.node_115.Weights)
    batchNormalizationLayer("Name","node_116","Offset",trainingSetup.node_116.Offset,"Scale",trainingSetup.node_116.Scale,"TrainedMean",trainingSetup.node_116.TrainedMean,"TrainedVariance",trainingSetup.node_116.TrainedVariance)
    reluLayer("Name","node_117")
    nnet.shufflenet.layer.ChannelShufflingLayer("shuffle_118to120",4)
    groupedConvolution2dLayer([3 3],1,272,"Name","node_121","Padding",[1 1 1 1],"Bias",trainingSetup.node_121.Bias,"Weights",trainingSetup.node_121.Weights)
    batchNormalizationLayer("Name","node_122","Offset",trainingSetup.node_122.Offset,"Scale",trainingSetup.node_122.Scale,"TrainedMean",trainingSetup.node_122.TrainedMean,"TrainedVariance",trainingSetup.node_122.TrainedVariance)
    groupedConvolution2dLayer([1 1],68,4,"Name","node_123","Bias",trainingSetup.node_123.Bias,"Weights",trainingSetup.node_123.Weights)
    batchNormalizationLayer("Name","node_124","Offset",trainingSetup.node_124.Offset,"Scale",trainingSetup.node_124.Scale,"TrainedMean",trainingSetup.node_124.TrainedMean,"TrainedVariance",trainingSetup.node_124.TrainedVariance)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","node_125")
    reluLayer("Name","node_126")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    groupedConvolution2dLayer([1 1],68,4,"Name","node_127","Bias",trainingSetup.node_127.Bias,"Weights",trainingSetup.node_127.Weights)
    batchNormalizationLayer("Name","node_128","Offset",trainingSetup.node_128.Offset,"Scale",trainingSetup.node_128.Scale,"TrainedMean",trainingSetup.node_128.TrainedMean,"TrainedVariance",trainingSetup.node_128.TrainedVariance)
    reluLayer("Name","node_129")
    nnet.shufflenet.layer.ChannelShufflingLayer("shuffle_130to132",4)
    groupedConvolution2dLayer([3 3],1,272,"Name","node_133","Padding",[1 1 1 1],"Bias",trainingSetup.node_133.Bias,"Weights",trainingSetup.node_133.Weights)
    batchNormalizationLayer("Name","node_134","Offset",trainingSetup.node_134.Offset,"Scale",trainingSetup.node_134.Scale,"TrainedMean",trainingSetup.node_134.TrainedMean,"TrainedVariance",trainingSetup.node_134.TrainedVariance)
    groupedConvolution2dLayer([1 1],68,4,"Name","node_135","Bias",trainingSetup.node_135.Bias,"Weights",trainingSetup.node_135.Weights)
    batchNormalizationLayer("Name","node_136","Offset",trainingSetup.node_136.Offset,"Scale",trainingSetup.node_136.Scale,"TrainedMean",trainingSetup.node_136.TrainedMean,"TrainedVariance",trainingSetup.node_136.TrainedVariance)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","node_137")
    reluLayer("Name","node_138")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    groupedConvolution2dLayer([1 1],68,4,"Name","node_139","Bias",trainingSetup.node_139.Bias,"Weights",trainingSetup.node_139.Weights)
    batchNormalizationLayer("Name","node_140","Offset",trainingSetup.node_140.Offset,"Scale",trainingSetup.node_140.Scale,"TrainedMean",trainingSetup.node_140.TrainedMean,"TrainedVariance",trainingSetup.node_140.TrainedVariance)
    reluLayer("Name","node_141")
    nnet.shufflenet.layer.ChannelShufflingLayer("shuffle_142to144",4)
    groupedConvolution2dLayer([3 3],1,272,"Name","node_145","Padding",[1 1 1 1],"Bias",trainingSetup.node_145.Bias,"Weights",trainingSetup.node_145.Weights)
    batchNormalizationLayer("Name","node_146","Offset",trainingSetup.node_146.Offset,"Scale",trainingSetup.node_146.Scale,"TrainedMean",trainingSetup.node_146.TrainedMean,"TrainedVariance",trainingSetup.node_146.TrainedVariance)
    groupedConvolution2dLayer([1 1],68,4,"Name","node_147","Bias",trainingSetup.node_147.Bias,"Weights",trainingSetup.node_147.Weights)
    batchNormalizationLayer("Name","node_148","Offset",trainingSetup.node_148.Offset,"Scale",trainingSetup.node_148.Scale,"TrainedMean",trainingSetup.node_148.TrainedMean,"TrainedVariance",trainingSetup.node_148.TrainedVariance)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","node_149")
    reluLayer("Name","node_150")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = averagePooling2dLayer([3 3],"Name","node_161","Padding",[1 1 1 1],"Stride",[2 2]);
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    groupedConvolution2dLayer([1 1],68,4,"Name","node_151","Bias",trainingSetup.node_151.Bias,"Weights",trainingSetup.node_151.Weights)
    batchNormalizationLayer("Name","node_152","Offset",trainingSetup.node_152.Offset,"Scale",trainingSetup.node_152.Scale,"TrainedMean",trainingSetup.node_152.TrainedMean,"TrainedVariance",trainingSetup.node_152.TrainedVariance)
    reluLayer("Name","node_153")
    nnet.shufflenet.layer.ChannelShufflingLayer("shuffle_154to156",4)
    groupedConvolution2dLayer([3 3],1,272,"Name","node_157","Padding",[1 1 1 1],"Stride",[2 2],"Bias",trainingSetup.node_157.Bias,"Weights",trainingSetup.node_157.Weights)
    batchNormalizationLayer("Name","node_158","Offset",trainingSetup.node_158.Offset,"Scale",trainingSetup.node_158.Scale,"TrainedMean",trainingSetup.node_158.TrainedMean,"TrainedVariance",trainingSetup.node_158.TrainedVariance)
    groupedConvolution2dLayer([1 1],68,4,"Name","node_159","Bias",trainingSetup.node_159.Bias,"Weights",trainingSetup.node_159.Weights)
    batchNormalizationLayer("Name","node_160","Offset",trainingSetup.node_160.Offset,"Scale",trainingSetup.node_160.Scale,"TrainedMean",trainingSetup.node_160.TrainedMean,"TrainedVariance",trainingSetup.node_160.TrainedVariance)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    depthConcatenationLayer(2,"Name","node_162")
    reluLayer("Name","node_163")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    groupedConvolution2dLayer([1 1],136,4,"Name","node_164","Bias",trainingSetup.node_164.Bias,"Weights",trainingSetup.node_164.Weights)
    batchNormalizationLayer("Name","node_165","Offset",trainingSetup.node_165.Offset,"Scale",trainingSetup.node_165.Scale,"TrainedMean",trainingSetup.node_165.TrainedMean,"TrainedVariance",trainingSetup.node_165.TrainedVariance)
    reluLayer("Name","node_166")
    nnet.shufflenet.layer.ChannelShufflingLayer("shuffle_167to169",4)
    groupedConvolution2dLayer([3 3],1,544,"Name","node_170","Padding",[1 1 1 1],"Bias",trainingSetup.node_170.Bias,"Weights",trainingSetup.node_170.Weights)
    batchNormalizationLayer("Name","node_171","Offset",trainingSetup.node_171.Offset,"Scale",trainingSetup.node_171.Scale,"TrainedMean",trainingSetup.node_171.TrainedMean,"TrainedVariance",trainingSetup.node_171.TrainedVariance)
    groupedConvolution2dLayer([1 1],136,4,"Name","node_172","Bias",trainingSetup.node_172.Bias,"Weights",trainingSetup.node_172.Weights)
    batchNormalizationLayer("Name","node_173","Offset",trainingSetup.node_173.Offset,"Scale",trainingSetup.node_173.Scale,"TrainedMean",trainingSetup.node_173.TrainedMean,"TrainedVariance",trainingSetup.node_173.TrainedVariance)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","node_174")
    reluLayer("Name","node_175")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    groupedConvolution2dLayer([1 1],136,4,"Name","node_176","Bias",trainingSetup.node_176.Bias,"Weights",trainingSetup.node_176.Weights)
    batchNormalizationLayer("Name","node_177","Offset",trainingSetup.node_177.Offset,"Scale",trainingSetup.node_177.Scale,"TrainedMean",trainingSetup.node_177.TrainedMean,"TrainedVariance",trainingSetup.node_177.TrainedVariance)
    reluLayer("Name","node_178")
    nnet.shufflenet.layer.ChannelShufflingLayer("shuffle_179to181",4)
    groupedConvolution2dLayer([3 3],1,544,"Name","node_182","Padding",[1 1 1 1],"Bias",trainingSetup.node_182.Bias,"Weights",trainingSetup.node_182.Weights)
    batchNormalizationLayer("Name","node_183","Offset",trainingSetup.node_183.Offset,"Scale",trainingSetup.node_183.Scale,"TrainedMean",trainingSetup.node_183.TrainedMean,"TrainedVariance",trainingSetup.node_183.TrainedVariance)
    groupedConvolution2dLayer([1 1],136,4,"Name","node_184","Bias",trainingSetup.node_184.Bias,"Weights",trainingSetup.node_184.Weights)
    batchNormalizationLayer("Name","node_185","Offset",trainingSetup.node_185.Offset,"Scale",trainingSetup.node_185.Scale,"TrainedMean",trainingSetup.node_185.TrainedMean,"TrainedVariance",trainingSetup.node_185.TrainedVariance)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","node_186")
    reluLayer("Name","node_187")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    groupedConvolution2dLayer([1 1],136,4,"Name","node_188","Bias",trainingSetup.node_188.Bias,"Weights",trainingSetup.node_188.Weights)
    batchNormalizationLayer("Name","node_189","Offset",trainingSetup.node_189.Offset,"Scale",trainingSetup.node_189.Scale,"TrainedMean",trainingSetup.node_189.TrainedMean,"TrainedVariance",trainingSetup.node_189.TrainedVariance)
    reluLayer("Name","node_190")
    nnet.shufflenet.layer.ChannelShufflingLayer("shuffle_191to193",4)
    groupedConvolution2dLayer([3 3],1,544,"Name","node_194","Padding",[1 1 1 1],"Bias",trainingSetup.node_194.Bias,"Weights",trainingSetup.node_194.Weights)
    batchNormalizationLayer("Name","node_195","Offset",trainingSetup.node_195.Offset,"Scale",trainingSetup.node_195.Scale,"TrainedMean",trainingSetup.node_195.TrainedMean,"TrainedVariance",trainingSetup.node_195.TrainedVariance)
    groupedConvolution2dLayer([1 1],136,4,"Name","node_196","Bias",trainingSetup.node_196.Bias,"Weights",trainingSetup.node_196.Weights)
    batchNormalizationLayer("Name","node_197","Offset",trainingSetup.node_197.Offset,"Scale",trainingSetup.node_197.Scale,"TrainedMean",trainingSetup.node_197.TrainedMean,"TrainedVariance",trainingSetup.node_197.TrainedVariance)];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","node_198")
    reluLayer("Name","node_199")
    globalAveragePooling2dLayer("Name","node_200")
    fullyConnectedLayer(7,"Name","fc")
    softmaxLayer("Name","node_203")
    classificationLayer("Name","classoutput")];
lgraph = addLayers(lgraph,tempLayers);

% 清理辅助函数变量
clear tempLayers;
%%
%{
连接层分支
%}
lgraph = connectLayers(lgraph,"node_4","node_15");
lgraph = connectLayers(lgraph,"node_4","node_5");
lgraph = connectLayers(lgraph,"node_15","node_16/in2");
lgraph = connectLayers(lgraph,"node_14","node_16/in1");
lgraph = connectLayers(lgraph,"node_17","node_18");
lgraph = connectLayers(lgraph,"node_17","node_28/in2");
lgraph = connectLayers(lgraph,"node_27","node_28/in1");
lgraph = connectLayers(lgraph,"node_29","node_30");
lgraph = connectLayers(lgraph,"node_29","node_40/in2");
lgraph = connectLayers(lgraph,"node_39","node_40/in1");
lgraph = connectLayers(lgraph,"node_41","node_42");
lgraph = connectLayers(lgraph,"node_41","node_52/in2");
lgraph = connectLayers(lgraph,"node_51","node_52/in1");
lgraph = connectLayers(lgraph,"node_53","node_54");
lgraph = connectLayers(lgraph,"node_53","node_64");
lgraph = connectLayers(lgraph,"node_63","node_65/in1");
lgraph = connectLayers(lgraph,"node_64","node_65/in2");
lgraph = connectLayers(lgraph,"node_66","node_67");
lgraph = connectLayers(lgraph,"node_66","node_77/in2");
lgraph = connectLayers(lgraph,"node_76","node_77/in1");
lgraph = connectLayers(lgraph,"node_78","node_79");
lgraph = connectLayers(lgraph,"node_78","node_89/in2");
lgraph = connectLayers(lgraph,"node_88","node_89/in1");
lgraph = connectLayers(lgraph,"node_90","node_91");
lgraph = connectLayers(lgraph,"node_90","node_101/in2");
lgraph = connectLayers(lgraph,"node_100","node_101/in1");
lgraph = connectLayers(lgraph,"node_102","node_103");
lgraph = connectLayers(lgraph,"node_102","node_113/in2");
lgraph = connectLayers(lgraph,"node_112","node_113/in1");
lgraph = connectLayers(lgraph,"node_114","node_115");
lgraph = connectLayers(lgraph,"node_114","node_125/in2");
lgraph = connectLayers(lgraph,"node_124","node_125/in1");
lgraph = connectLayers(lgraph,"node_126","node_127");
lgraph = connectLayers(lgraph,"node_126","node_137/in2");
lgraph = connectLayers(lgraph,"node_136","node_137/in1");
lgraph = connectLayers(lgraph,"node_138","node_139");
lgraph = connectLayers(lgraph,"node_138","node_149/in2");
lgraph = connectLayers(lgraph,"node_148","node_149/in1");
lgraph = connectLayers(lgraph,"node_150","node_161");
lgraph = connectLayers(lgraph,"node_150","node_151");
lgraph = connectLayers(lgraph,"node_161","node_162/in2");
lgraph = connectLayers(lgraph,"node_160","node_162/in1");
lgraph = connectLayers(lgraph,"node_163","node_164");
lgraph = connectLayers(lgraph,"node_163","node_174/in2");
lgraph = connectLayers(lgraph,"node_173","node_174/in1");
lgraph = connectLayers(lgraph,"node_175","node_176");
lgraph = connectLayers(lgraph,"node_175","node_186/in2");
lgraph = connectLayers(lgraph,"node_185","node_186/in1");
lgraph = connectLayers(lgraph,"node_187","node_188");
lgraph = connectLayers(lgraph,"node_187","node_198/in2");
lgraph = connectLayers(lgraph,"node_197","node_198/in1");
%%
%{
训练网络
%}
[net, traininfo] = trainNetwork(augimdsTrain,lgraph,opts);