function Callbacks_autocorrelation_estimates_GUI25(f,C,start_path)
%SENSE COMPUTER AND SET FILE DELIMITER
switch(computer)				
    case 'MACI64',		char= '/';
    case 'GLNX86',  char='/';
    case 'PCWIN',	char= '\';
    case 'PCWIN64', char='\';
    case 'GLNXA64', char='/';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x=C{1,1};
y=C{1,2};
a=C{1,3};
b=C{1,4};
u=C{1,5};
v=C{1,6};
m=C{1,7};
n=C{1,8};
lengthbutton=C{1,9};
widthbutton=C{1,10};
enterType=C{1,11};
enterString=C{1,12};
enterLabel=C{1,13};
noPanels=C{1,14};
noGraphicPanels=C{1,15};
noButtons=C{1,16};
labelDist=C{1,17};%distance that the label is below the button
noTitles=C{1,18};
buttonTextSize=C{1,19};
labelTextSize=C{1,20};
textboxFont=C{1,21};
textboxString=C{1,22};
textboxWeight=C{1,23};
textboxAngle=C{1,24};
labelHeight=C{1,25};
fileName=C{1,26};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PANELS
for j=0:noPanels-1
uipanel('Parent',f,...
'Units','Normalized',...
'Position',[x(1+4*j) y(1+4*j) x(2+4*j)-x(1+4*j) y(3+4*j)-y(2+4*j)]);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%GRAPHIC PANELS
for i=0:noGraphicPanels-1
switch (i+1)
case 1
graphicPanel1 = axes('parent',f,...
'Units','Normalized',...
'Position',[a(1+4*i) b(1+4*i) a(2+4*i)-a(1+4*i) b(3+4*i)-b(2+4*i)],...
'GridLineStyle','--');
case 2
graphicPanel2 = axes('parent',f,...
'Units','Normalized',...
'Position',[a(1+4*i) b(1+4*i) a(2+4*i)-a(1+4*i) b(3+4*i)-b(2+4*i)],...
'GridLineStyle','--');
case 3
graphicPanel3 = axes('parent',f,...
'Units','Normalized',...
'Position',[a(1+4*i) b(1+4*i) a(2+4*i)-a(1+4*i) b(3+4*i)-b(2+4*i)],...
'GridLineStyle','--');
case 4
graphicPanel4 = axes('parent',f,...
'Units','Normalized',...
'Position',[a(1+4*i) b(1+4*i) a(2+4*i)-a(1+4*i) b(3+4*i)-b(2+4*i)],...
'GridLineStyle','--');
case 5
graphicPanel5 = axes('parent',f,...
'Units','Normalized',...
'Position',[a(1+4*i) b(1+4*i) a(2+4*i)-a(1+4*i) b(3+4*i)-b(2+4*i)],...
'GridLineStyle','--');
case 6
graphicPanel6 = axes('parent',f,...
'Units','Normalized',...
'Position',[a(1+4*i) b(1+4*i) a(2+4*i)-a(1+4*i) b(3+4*i)-b(2+4*i)],...
'GridLineStyle','--');
case 7
graphicPanel7 = axes('parent',f,...
'Units','Normalized',...
'Position',[a(1+4*i) b(1+4*i) a(2+4*i)-a(1+4*i) b(3+4*i)-b(2+4*i)],...
'GridLineStyle','--');
case 8
graphicPanel8 = axes('parent',f,...
'Units','Normalized',...
'Position',[a(1+4*i) b(1+4*i) a(2+4*i)-a(1+4*i) b(3+4*i)-b(2+4*i)],...
'GridLineStyle','--');
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TITLE BOXES
for k=0:noTitles-1
switch (k+1)
case 1
titleBox1 = uicontrol('parent',f,...
'Units','Normalized',...
'Position',[u(1+4*k) v(1+4*k) u(2+4*k)-u(1+4*k) v(3+4*k)-v(2+4*k)],...
'Style','text',...
'FontSize',textboxFont{k+1},...
'String',textboxString(k+1),...
'FontWeight',textboxWeight{k+1},...
'FontAngle',textboxAngle{k+1});
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BUTTONS
for i=0:(noButtons-1)
enterColor='w';
if strcmp(enterType{i+1},'pushbutton')==1 ||strcmp(enterType{i+1},'text')==1
enterColor='default';
end
if (strcmp(enterLabel{1,(i+1)},'')==0 &&...
        strcmp(enterLabel{1,(i+1)},'...')==0) %i.e. there is a label
%creating a label for some buttons
uicontrol('Parent',f,...
'Units','Normalized',...
'Position',[m(1+2*i) n(1+2*i)-labelDist-labelHeight(i+1) ...
(m(2+2*i)-m(1+2*i)) labelHeight(i+1)],...
'Style','text',...
'String',enterLabel{i+1},...
'FontSize', labelTextSize(i+1),...
'HorizontalAlignment','center');
end
switch (i+1)
case 1
button1=uicontrol('Parent',f,...
'Units','Normalized',...
'Position',[m(1+2*i) n(1+2*i) (m(2+2*i)-m(1+2*i)) (n(2+2*i)-n(1+2*i))],...
'Style',enterType{i+1},...
'String',enterString{i+1},...
'FontSize', buttonTextSize(1+i),...
'BackgroundColor',enterColor,...
'HorizontalAlignment','center',...
'Callback',@button1Callback);
case 2
button2=uicontrol('Parent',f,...
'Units','Normalized',...
'Position',[m(1+2*i) n(1+2*i) (m(2+2*i)-m(1+2*i)) (n(2+2*i)-n(1+2*i))],...
'Style',enterType{i+1},...
'String',enterString{i+1},...
'FontSize', buttonTextSize(1+i),...
'BackgroundColor',enterColor,...
'HorizontalAlignment','center',...
'Callback',@button2Callback);
case 3
button3=uicontrol('Parent',f,...
'Units','Normalized',...
'Position',[m(1+2*i) n(1+2*i) (m(2+2*i)-m(1+2*i)) (n(2+2*i)-n(1+2*i))],...
'Style',enterType{i+1},...
'String',enterString{i+1},...
'FontSize', buttonTextSize(1+i),...
'BackgroundColor',enterColor,...
'HorizontalAlignment','center',...
'Callback',@button3Callback);
case 4
button4=uicontrol('Parent',f,...
'Units','Normalized',...
'Position',[m(1+2*i) n(1+2*i) (m(2+2*i)-m(1+2*i)) (n(2+2*i)-n(1+2*i))],...
'Style',enterType{i+1},...
'String',enterString{i+1},...
'FontSize', buttonTextSize(1+i),...
'BackgroundColor',enterColor,...
'HorizontalAlignment','center',...
'Callback',@button4Callback);
case 5
button5=uicontrol('Parent',f,...
'Units','Normalized',...
'Position',[m(1+2*i) n(1+2*i) (m(2+2*i)-m(1+2*i)) (n(2+2*i)-n(1+2*i))],...
'Style',enterType{i+1},...
'String',enterString{i+1},...
'FontSize', buttonTextSize(1+i),...
'BackgroundColor',enterColor,...
'HorizontalAlignment','center',...
'Callback',@button5Callback);
case 6
button6=uicontrol('Parent',f,...
'Units','Normalized',...
'Position',[m(1+2*i) n(1+2*i) (m(2+2*i)-m(1+2*i)) (n(2+2*i)-n(1+2*i))],...
'Style',enterType{i+1},...
'String',enterString{i+1},...
'FontSize', buttonTextSize(1+i),...
'BackgroundColor',enterColor,...
'HorizontalAlignment','center',...
'Callback',@button6Callback);
case 7
button7=uicontrol('Parent',f,...
'Units','Normalized',...
'Position',[m(1+2*i) n(1+2*i) (m(2+2*i)-m(1+2*i)) (n(2+2*i)-n(1+2*i))],...
'Style',enterType{i+1},...
'String',enterString{i+1},...
'FontSize', buttonTextSize(1+i),...
'BackgroundColor',enterColor,...
'HorizontalAlignment','center',...
'Callback',@button7Callback);
case 8
button8=uicontrol('Parent',f,...
'Units','Normalized',...
'Position',[m(1+2*i) n(1+2*i) (m(2+2*i)-m(1+2*i)) (n(2+2*i)-n(1+2*i))],...
'Style',enterType{i+1},...
'String',enterString{i+1},...
'FontSize', buttonTextSize(1+i),...
'BackgroundColor',enterColor,...
'HorizontalAlignment','center',...
'Callback',@button8Callback);
case 9
button9=uicontrol('Parent',f,...
'Units','Normalized',...
'Position',[m(1+2*i) n(1+2*i) (m(2+2*i)-m(1+2*i)) (n(2+2*i)-n(1+2*i))],...
'Style',enterType{i+1},...
'String',enterString{i+1},...
'FontSize', buttonTextSize(1+i),...
'BackgroundColor',enterColor,...
'HorizontalAlignment','center',...
'Callback',@button9Callback);
case 10
button10=uicontrol('Parent',f,...
'Units','Normalized',...
'Position',[m(1+2*i) n(1+2*i) (m(2+2*i)-m(1+2*i)) (n(2+2*i)-n(1+2*i))],...
'Style',enterType{i+1},...
'String',enterString{i+1},...
'FontSize', buttonTextSize(1+i),...
'BackgroundColor',enterColor,...
'HorizontalAlignment','center',...
'Callback',@button10Callback);
case 11
button11=uicontrol('Parent',f,...
'Units','Normalized',...
'Position',[m(1+2*i) n(1+2*i) (m(2+2*i)-m(1+2*i)) (n(2+2*i)-n(1+2*i))],...
'Style',enterType{i+1},...
'String',enterString{i+1},...
'FontSize', buttonTextSize(1+i),...
'BackgroundColor',enterColor,...
'HorizontalAlignment','center',...
'Callback',@button11Callback);
case 12
button12=uicontrol('Parent',f,...
'Units','Normalized',...
'Position',[m(1+2*i) n(1+2*i) (m(2+2*i)-m(1+2*i)) (n(2+2*i)-n(1+2*i))],...
'Style',enterType{i+1},...
'String',enterString{i+1},...
'FontSize', buttonTextSize(1+i),...
'BackgroundColor',enterColor,...
'HorizontalAlignment','center',...
'Callback',@button12Callback);
case 13
button13=uicontrol('Parent',f,...
'Units','Normalized',...
'Position',[m(1+2*i) n(1+2*i) (m(2+2*i)-m(1+2*i)) (n(2+2*i)-n(1+2*i))],...
'Style',enterType{i+1},...
'String',enterString{i+1},...
'FontSize', buttonTextSize(1+i),...
'BackgroundColor',enterColor,...
'HorizontalAlignment','center',...
'Callback',@button13Callback);
case 14
button14=uicontrol('Parent',f,...
'Units','Normalized',...
'Position',[m(1+2*i) n(1+2*i) (m(2+2*i)-m(1+2*i)) (n(2+2*i)-n(1+2*i))],...
'Style',enterType{i+1},...
'String',enterString{i+1},...
'FontSize', buttonTextSize(1+i),...
'BackgroundColor',enterColor,...
'HorizontalAlignment','center',...
'Callback',@button14Callback);
case 15
button15=uicontrol('Parent',f,...
'Units','Normalized',...
'Position',[m(1+2*i) n(1+2*i) (m(2+2*i)-m(1+2*i)) (n(2+2*i)-n(1+2*i))],...
'Style',enterType{i+1},...
'String',enterString{i+1},...
'FontSize', buttonTextSize(1+i),...
'BackgroundColor',enterColor,...
'HorizontalAlignment','center',...
'Callback',@button15Callback);
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%USER CODE FOR THE VARIABLES AND CALLBACKS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize Variables
    curr_file=1;
    fs=1;
    directory_name='abcd';
    wav_file_names='abce';
    fin_path='filename';
    fname='output';
    file_info_string=' ';
    nsamp=1;
    fwrite='out_autocorrelation_estimates';
    wtype=1;
    ss=2000;
    Lm=40;
    L=400;
    Rm=10;
    R=100;
    pdlow=2.5;
    pdhigh=12.5;
    K=pdhigh;
    P=60;

% Name the GUI
    set(f,'Name','autocorrelation_estimates_GUI');


% CALLBACKS
% Callback for button1 -- Get Speech Files Directory
 function button1Callback(h,eventdata)
     directory_name=uigetdir(start_path,'dialog_title');
%      if isempty(getpref('SpeechApps'))
%          url = sprintf('%s%s%s',...
%              'http://www.mathworks.com/matlabcentral/fileexchange/',...
%              '42911-speech-and-audio-files-for-speech-processing-excercises',...
%              '?download=true');
%          [saveloc,~,~] = fileparts(pwd); %save to one level up from current folder
%          % Create a waitbar during download
%          h = waitbar(0.35,'This may take several minutes...',...
%              'Name','Downloading Speech Files...');
%          % Download the zipped file
%          [filestr,status] = urlwrite(url,[saveloc filesep 'speech_files.zip'],...
%              'Timeout',10);
%          if status
%              delete(h);
%              hh1= helpdlg('Downloaded. Select a location to UNZIP the speech files.');
%              uiwait(hh1);
%              unziploc = uigetdir(saveloc,'Select a location to unzip the speech files');
%              h2 = waitbar(0.2,'This may take a minute...',...
%                  'Name','Unzipping the Speech Files to Location Selected...');
%              unzip(filestr,unziploc);
%              delete(h2)
%              addpref('SpeechApps','path',unziploc);
%              hh2= helpdlg('Ready. Select the speech_files folder in the next window');
%              uiwait(hh2);
%          else
%              warndlg('No Internet Connection to MATLAB Central!');
%          end
%          
%      else
%      end
%      directory_name=uigetdir(getpref('SpeechApps','path'));
     A=strvcat(strcat((directory_name),[char,'*.wav']));
     struct_filenames=dir(A);
     wav_file_names={struct_filenames.name};
     set(button2,'String',wav_file_names);
     
% once the popupmenu/drop down menu is created, by default, the first
% selection from the popupmenu/drop down menu id not called
    indexOfDrpDwnMenu=1;
    
% by default first option from the popupmenu/dropdown menu will be loaded
    [curr_file,fs]=loadSelection(directory_name,wav_file_names,indexOfDrpDwnMenu);
 end

% Callback for button2 -- Choose speech file for play and plot
 function button2Callback(h,eventdata)
     indexOfDrpDwnMenu=get(button2,'val');
     [curr_file,fs]=loadSelection(directory_name,wav_file_names,indexOfDrpDwnMenu);
 end

%*************************************************************************
% function -- load selection from designated directory and file
%
function [curr_file,fs]=loadSelection(directory_name,wav_file_names,...
    indexOfDrpDwnMenu);
%
% read in speech/audio file
% fin_path is the complete path of the .wav file that is selected
    fin_path=strcat(directory_name,char,strvcat(wav_file_names(indexOfDrpDwnMenu)));
    
% clear speech/audio file
    clear curr_file;
    
% read in speech/audio signal into curr_file; sampling rate is fs 
    [curr_file,fs]=wavread(fin_path);
    
% create title information with file, sampling rate, number of samples
    fname=wav_file_names(indexOfDrpDwnMenu);
    FS=num2str(fs);
    nsamp=num2str(length(curr_file));
    file_info_string=strcat('  file: ',fname,', fs: ',FS,' Hz, nsamp:',nsamp);
    
% retrieve filename (fname) from cell array
    fname=wav_file_names{indexOfDrpDwnMenu};
    
% correct filename for underbar characters
    fname(find(fname(:)=='_'))=' ';
end

% Callback for button13 -- Play Speech File
 function button13Callback(h,eventdata)
     soundsc(curr_file,fs);
 end

% Callback for button3 -- wtype: Window Type (1:Hamming, 2:Rectangular)
 function button3Callback(h,eventdata)
     wtype=get(button3,'val');
 end

% Callback for button4 -- ss: starting sample in file for AC plot, as
% determined by interactive graphics cursors
 function button4Callback(h,eventdata)
     ss=str2num(get(button4,'string'));
     if (ss < 1 || ss > length(curr_file)-Lm*(fs/1000))
         waitfor(errordlg('Starting smaple must be between 1 and length of fisle')) 
     end
 end

% Callback for button5 -- Lm: window duration in msec
 function button5Callback(h,eventdata)
     Lm=str2num(get(button5,'string'));
     if ~((Lm >= 1 && Lm <=100))
         waitfor(errordlg('Lm must be a positive number between 1 and 100'))
     end
 end

% Callback for button6 -- Rm: window shift in msec
 function button6Callback(h,eventdata)
     Rm=str2num(get(button6,'string'));
     if ~((Rm >= 1 && Rm <=100))
         waitfor(errordlg('Rm must be a positive numbser between 1 and 100'))
     end
 end

% Callback for button7 -- pdlow: shortest pitch period (msec)
 function button7Callback(h,eventdata)
     pdlow=str2num(get(button7,'string'));
     if ~((pdlow >= 2 && pdlow <=5))
         waitfor(errordlg('pdlow must be between 2 to 5 msec'))
     end
 end

% Callback for button8 -- pdhigh: longest pitch period (msec)
 function button8Callback(h,eventdata)
     pdhigh=str2num(get(button8,'string'));
     if ~((pdhigh >= 10 && pdhigh <= 15))
         waitfor(errordlg('pdhigh must be between 10 to 15 msec'))
     end
     K=pdhigh;
 end

% Callback for button9 -- P: clipping level (%)
 function button9Callback(h,eventdata)
     P=str2num(get(button9,'string'));
     if ~((P >= 0 && P <=100))
         waitfor(errordlg('P must be a positive integer between 0 and 100'))
     end
 end

% Callback for button10 -- Get Current Frame Starting Sample
 function button10Callback(h,eventdata)
    
% use graphicsPanel7 to display entire speech file and then home in on
% desired starting sample using graphics cursors
    Lm=str2num(get(button5,'string'));
    ss=plot_speech_cursor(curr_file,1,1,graphicPanel7);
    L=round(Lm*fs/1000);
    set(button4,'string',num2str(ss));
 end

% Callback for button 15 -- Run Analysis from Current Frame
    function button15Callback(h,eventdata)
    
% callbacks to buttons 2-9 for up-to-date data
    button2Callback(h,eventdata);
    wtype=get(button3,'val');
    Lm=str2num(get(button5,'string'));
    Rm=str2num(get(button6,'string'));
    pdlow=str2num(get(button7,'string'));
    pdhigh=str2num(get(button8,'string'));
    K=pdhigh;
    P=str2num(get(button9,'string'));
        
% fwrite=output text file with results of autocorrelation analysis
    fwrite='out_autocorrelation_estimates';
    fclose('all');
    fid=fopen(fwrite,'w');
    
% save filename information in output file
    fprintf(fid,'fname: %s, sampling rate: %d \n',fname,fs);
    
% get results of each of four AC analyses
    [L,R,K,pdlow,period,plevel,peakac,ac1,ac2,ac3,ac4,xw1,xw2,xw3,xw4,xwe2,xwe3,xwe4]=...
        autocorrelation_analysis(curr_file,fs,wtype,ss,Lm,Rm,pdlow,K,P,fid);
        peak1=period(1); peak2=period(2); peak3=period(3); peak4=period(4);
    
% fill in titleBox1 with autocorrelation estimation parameters
    s1=sprintf('Autocorrelations - %s, ss: %d, ',fname,ss);
    s2=sprintf(' L: %d,R: %d, ',L,R);
    s3=sprintf(' maxlag: %d, CL: %d',K,P);
    stitle=strcat(s1,s2,s3);
    set(titleBox1,'String',stitle);
    set(titleBox1,'FontSize',15);
            
% plot the 4 autocorrelation functions
% plot signal used for short-time autocorrelation analysis in graphics Panel 7
            kindex=0:K;
            nindex1=0:L-1;
            reset(graphicPanel7);
            axes(graphicPanel7);
            plot(nindex1,xw1,'b','LineWidth',2);
            axis ([0 L+K-1 min(xw1) max(xw1)]);
            grid on;
            ac1min=min(ac1);ac1max=max(ac1);
            
% plot short-time autocorrelation analysis in graphics Panel 8
            reset(graphicPanel8);
            axes(graphicPanel8);
            plot(kindex,ac1,'b','LineWidth',2),axis tight,...
            grid on,hold on,legend('short time ac','location','NorthWest');
            plot([pdlow pdlow],[ac1min ac1max],'k:','LineWidth',2),...
            	plot([peak1 peak1],[ac1min ac1max],'r','LineWidth',2);
            nindex2=0:K+L-2;
            
% plot signal used for modified correlation analysis in graphics Panel 5
            reset(graphicPanel5);
            axes(graphicPanel5);
            plot(nindex1,xw2,'b','LineWidth',2),hold on;
            plot(nindex2,xwe2,'r:','LineWidth',2),axis tight,grid on;
            ac2min=min(ac2);ac2max=max(ac2);
            
% plot modified correlation analysis in graphics Panel 6
            reset(graphicPanel6);
            axes(graphicPanel6);
            plot(kindex,ac2,'b','LineWidth',2),axis tight,...
            hold on,legend('modified ac','location','NorthWest');
            plot([pdlow pdlow],[ac2min ac2max],'k:','LineWidth',2),grid on,...
            	plot([peak2 peak2],[ac2min ac2max],'r','LineWidth',2);
            
% plot center-clipped signal used for modified correlation in graphics Panel 3
            reset(graphicPanel3);
            axes(graphicPanel3);
            plot(nindex1,xw3,'b','LineWidth',2),hold on;
            plot(nindex2,xwe3,'r:','LineWidth',2),grid on,axis tight;
            ac3min=min(ac3);ac3max=max(ac3);
            
% plot resulting modified correlation, from center-clipping, in graphics Panel 4
            reset(graphicPanel4);
            axes(graphicPanel4);
            plot(kindex,ac3,'b','LineWidth',2),axis tight;
            hold on,legend('center clipped ac','location','NorthWest');
            plot([pdlow pdlow],[ac3min ac3max],'k:','LineWidth',2),grid on;
            plot([peak3 peak3],[ac3min ac3max],'r','LineWidth',2);
            
% plot 3-level center clipped signal in grpahics Panel 1
            reset(graphicPanel1);
            axes(graphicPanel1);
            plot(nindex1,xw4,'b','LineWidth',2),hold on;
            plot(nindex2,xwe4,'r:','LineWidth',2),axis tight,grid on;
                xpp=['Time in Samples; fs=',num2str(fs),' samples/second'];
            	xlabel(xpp),ylabel('Amplitude');
                ac4min=min(ac4);ac4max=max(ac4);
                
% plot resulting modified correlation, from 3-level center clipping, in
% graphics Panel 2
            reset(graphicPanel2);
            axes(graphicPanel2);
            plot(kindex,ac4,'b','LineWidth',2),axis tight,...
            hold on,grid on,legend('3-level ac','location','NorthWest');
            plot([pdlow pdlow],[ac4min ac4max],'k:','LineWidth',2);
            xpp=['Lag in Samples; fs=',num2str(fs),' samples/second'];
            xlabel(xpp),ylabel('Normalized AC'),...
            plot([peak4 peak4],[ac4min ac4max],'r','LineWidth',2);
        
% print out to fid each of 4 correlation peaks
    fprintf(fid,'ss: %d, peak1/2/3/4: %d %d %d %d,',ss,period(1),...
        period(2),period(3),period(4));
    fprintf(fid,' level1/2/3/4: %4.2f %4.2f %4.2f %4.2f \n',peakac(1),...
        peakac(2),peakac(3),peakac(4));
    fprintf('ss: %d, peak1/2/3/4: %d %d %d %d,',ss,period(1),period(2),...
        period(3),period(4));
    fprintf(' level1/2/3/4: %4.2f %4.2f %4.2f %4.2f ',peakac(1),...
        peakac(2),peakac(3),peakac(4));
    fprintf(' ac1/2/3/4: %4.2f %4.2f %4.2f %4.2f \n',plevel(1),...
        plevel(2),plevel(3),plevel(4));
 end
    
% Callback for button 14 -- Run Next Frame
    function button14Callback(h,eventdata)
% update starting sample counter for next frame
    ss=ss+R;
    set(button4,'string',num2str(ss));
    button15Callback(h,eventdata)
 end 

% Callback for button11 -- Run Pitch Detector
 function button11Callback(h,eventdata)
% callbacks to buttons 2-9 for up-to-date data
    
    button2Callback(h,eventdata);
    wtype=get(button3,'val');
    ss=1; %str2num(get(button4,'string'));
    set(button4,'string',num2str(ss));
    Lm=str2num(get(button5,'string'));
    Rm=str2num(get(button6,'string'));
    pdlow=str2num(get(button7,'string'));
    pdhigh=str2num(get(button8,'string'));
    K=pdhigh;
    P=str2num(get(button9,'string'));
    
% fwrite=output text file with results of autocorrelation analysis
    fclose('all');
    fwrite='out_autocorrelation_estimates';
    fid=fopen(fwrite,'w');
    
% save filename information in output file
    fprintf(fid,'fname: %s, sampling rate: %d \n',fname,fs);
    
% AC pitch detector
    ss=1;
    [L,R,K,pdlow,period,plevel,peakac,ploc]=...
        autocorrelation_pitch_detector(curr_file,fs,wtype,ss,Lm,...
        Rm,pdlow,K,P,fid,fname);
    ss=1; %str2num(get(button4,'string'));
    set(button4,'string',num2str(ss));
 end

% Callback for button12 -- Close GUI
 function button12Callback(h,eventdata)
     fclose('all');
     close(gcf);
 end
end