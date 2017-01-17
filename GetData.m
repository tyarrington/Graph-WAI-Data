function [Zvector_Mimosa_left,Zvector_Titan_left,Zvector_ER10x_left,Zvector_Mimosa_right,Zvector_Titan_right,Zvector_ER10x_right] = GetData(Mimosa_right_filename,Mimosa_left_filename,Titan_right_filename,Titan_left_filename,Titan_right_filename_modified,Titan_left_filename_modified,ER10x_right_filename,ER10x_left_filename,datadir_Mimosa,datadir_Titan,datadir_ER10x)


Titan_Area=pi*(0.0079375/2)^2;
%Titan_Area=pi*(0.0115/2)^2;
Zo_Titan = 344*1.2/Titan_Area;  % mks with Mimosa constants

Mimosa_Area=pi*(0.0075/2)^2;
%Mimosa_Area=pi*(0.0115/2)^2;
Zo_Mimosa=344*1.2/Mimosa_Area;

ER10x_Area=pi*(0.0079375/2)^2;
%ER10x_Area=pi*(0.0115/2)^2;
Zo_ER10x=344*1.2/ER10x_Area;


 %Plot and organize data from Mimosa
 
    eval(['load ', datadir_Mimosa, '\',   Mimosa_right_filename,' ', '''-mat''']) % changed to back slash
   
    % loads in exportData.data 
    Freq_Mimosa=exportData.data{1}(:,1);
    Complex_R=exportData.data{1}(:,2);
    PowerReflectance=abs(Complex_R).^2;
    Absorbance_Mimosa=1-PowerReflectance;
    Znorm_Mimosa=(1+Complex_R)./(1-Complex_R);
    Z_Mimosa=Znorm_Mimosa*Zo_Mimosa;
    Zmag_Mimosa=abs(Z_Mimosa);
    Zang_Mimosa=angle(Z_Mimosa)/2/pi;

    
    %Loads in Titan Data
    eval(['run ', datadir_Titan, '\', Titan_right_filename]) % changed to back slash
    eval(['Freq_Titan=',Titan_right_filename_modified,'.FREQ.'';']);
    eval(['ABSORB_Titan=',Titan_right_filename_modified,'.ABS.'';']);
    eval(['Amag_Titan=',Titan_right_filename_modified,'.ADMITTANCE_MAG.''*.001/1e5;']) ; %units of admittance. cgs mmhos, put in mks mhos here
    eval(['Aang_Titan=',Titan_right_filename_modified,'.ADMITTANCE_ANGLE.''/360;']);  % units of admittance angle is degrees, but in cycles here
    A_Titan=Amag_Titan.*exp(j*2*pi*Aang_Titan);
  
    Zmag_Titan=abs(1./(A_Titan));
    Zang_Titan=angle(1./A_Titan)/2/pi;
    
    
    %Loads in ER10x Data
    eval(['load ', 'C:\Users\vosslab\Desktop\R15_WAI\ER10x_Data\GoodCalibration_20150919\freq.mat',   ' ', '''-mat'''])
    eval(['load ', datadir_ER10x, '\',   ER10x_right_filename,' ', '''-mat'''])
    
    Freq_ER10x=freq;
    Z_ER10x=Zear*1e5; % change from cgs to mks %%%%%%%%
 
    Zmag_ER10x=abs(Z_ER10x);
    Zang_ER10x=angle(Z_ER10x)/2/pi;
    Znorm_ER10x=Z_ER10x/Zo_ER10x;
    Complex_R_ER10x=(Znorm_ER10x-1)./(Znorm_ER10x+1);
    PowerReflectance_ER10x=abs(Complex_R_ER10x).^2;
    Absorbance_ER10x=1-PowerReflectance_ER10x;
    
  
    Mimosa_ones_vector=ones(size(Freq_Mimosa));
    Titan_ones_vector=ones(size(Freq_Titan));
    ER10x_ones_vector=ones(size(Freq_ER10x));
    Zvector_Mimosa_right=[Freq_Mimosa  Absorbance_Mimosa  Zmag_Mimosa Zang_Mimosa  ];
    Zvector_Titan_right= [Freq_Titan   ABSORB_Titan       Zmag_Titan  Zang_Titan ];
    Zvector_ER10x_right= [Freq_ER10x   Absorbance_ER10x   Zmag_ER10x  Zang_ER10x ];


%%%%%%%%%%%%%%%  left %%%%%%%%%%%%%%%%%%%%%%%%%

    eval(['load ', datadir_Mimosa, '\',   Mimosa_left_filename,' ', '''-mat''']) % changed to back slash
   
    % loads in exportData.data 
    Freq_Mimosa=exportData.data{1}(:,1);
    Complex_R=exportData.data{1}(:,2);
    PowerReflectance=abs(Complex_R).^2;
    Absorbance_Mimosa=1-PowerReflectance;
    Znorm_Mimosa=(1+Complex_R)./(1-Complex_R);
    Z_Mimosa=Znorm_Mimosa*Zo_Mimosa;
    Zmag_Mimosa=abs(Z_Mimosa);
    Zang_Mimosa=angle(Z_Mimosa)/2/pi;

    
    %Loads in Titan Data
    eval(['run ', datadir_Titan, '\', Titan_left_filename]) % changed to back slash
    eval(['Freq_Titan=',Titan_left_filename_modified,'.FREQ.'';']);
    eval(['ABSORB_Titan=',Titan_left_filename_modified,'.ABS.'';']);
    eval(['Amag_Titan=',Titan_left_filename_modified,'.ADMITTANCE_MAG.''*.001/1e5;']) ; %units of admittance. cgs mmhos, put in mks mhos here
    eval(['Aang_Titan=',Titan_left_filename_modified,'.ADMITTANCE_ANGLE.''/360;']);  % units of admittance angle is degrees, but in cycles here
    A_Titan=Amag_Titan.*exp(j*2*pi*Aang_Titan);
  
    Zmag_Titan=abs(1./(A_Titan));
    Zang_Titan=angle(1./A_Titan)/2/pi;
    
    
    %Loads in ER10x Data
    eval(['load ', 'C:\Users\vosslab\Desktop\R15_WAI\ER10x_Data\GoodCalibration_20150919\freq.mat',   ' ', '''-mat'''])
    eval(['load ', datadir_ER10x, '\',   ER10x_left_filename,' ', '''-mat'''])
    
    Freq_ER10x=freq;
    Z_ER10x=Zear*1e5; % change from cgs to mks
 
    Zmag_ER10x=abs(Z_ER10x);
    Zang_ER10x=angle(Z_ER10x)/2/pi;
    Znorm_ER10x=Z_ER10x/Zo_ER10x;
    Complex_R_ER10x=(Znorm_ER10x-1)./(Znorm_ER10x+1);
    PowerReflectance_ER10x=abs(Complex_R_ER10x).^2;
    Absorbance_ER10x=1-PowerReflectance_ER10x;
    
  
    Mimosa_ones_vector=ones(size(Freq_Mimosa));
    Titan_ones_vector=ones(size(Freq_Titan));
    ER10x_ones_vector=ones(size(Freq_ER10x));
    Zvector_Mimosa_left=[Freq_Mimosa  Absorbance_Mimosa  Zmag_Mimosa Zang_Mimosa  ];
    Zvector_Titan_left= [Freq_Titan   ABSORB_Titan       Zmag_Titan  Zang_Titan ];
    Zvector_ER10x_left= [Freq_ER10x   Absorbance_ER10x   Zmag_ER10x  Zang_ER10x ];








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    fax=([100 10000]);
    fay_Absorb=[0 1.1];
    fay_Zang=[-.3 .3];
    fay_Zmag=[1e6 1e9];
    
     
figure(1)
    orient tall 
     
            subplot(321)
            semilogx(Zvector_Mimosa_left(:,1),Zvector_Mimosa_left(:,2),'b')
            hold on
            semilogx(Zvector_Titan_left(:,1),Zvector_Titan_left(:,2),'c')
            hold on
            semilogx(Zvector_ER10x_left(:,1),Zvector_ER10x_left(:,2),'k')
            xlim(fax)
            ylim(fay_Absorb)
            ylabel('Absorbance')
            title('Left Ear')
            
            subplot(323)
            loglog(Zvector_Mimosa_left(:,1),Zvector_Mimosa_left(:,3),'b')
            hold on
            loglog(Zvector_Titan_left(:,1),Zvector_Titan_left(:,3),'c')
            hold on
            loglog(Zvector_ER10x_left(:,1),Zvector_ER10x_left(:,3),'k')
            xlim(fax)
            ylim(fay_Zmag)
            ylabel('Z mag (mks Ohms)')
            
            subplot(325)
            semilogx(Zvector_Mimosa_left(:,1),Zvector_Mimosa_left(:,4),'b')
            hold on
            semilogx(Zvector_Titan_left(:,1),Zvector_Titan_left(:,4),'c')
            hold on
            semilogx(Zvector_ER10x_left(:,1),Zvector_ER10x_left(:,4),'k')
            xlim(fax)
            ylim(fay_Zang)
            xlabel('Frequency (Hz)')
            ylabel('Z angle (cycles)')
            legend('Mimosa L', 'Titan L','ER10x L','Location','NorthWest')
        
            % right ear
            subplot(322)
            semilogx(Zvector_Mimosa_right(:,1),Zvector_Mimosa_right(:,2),'r')
            hold on
            semilogx(Zvector_Titan_right(:,1),Zvector_Titan_right(:,2),'m')
            hold on
            semilogx(Zvector_ER10x_right(:,1),Zvector_ER10x_right(:,2),'g')
            xlim(fax)
            ylim(fay_Absorb)
            ylabel('Absorbance')
            title('Right Ear')
            
            subplot(324)
            loglog(Zvector_Mimosa_right(:,1),Zvector_Mimosa_right(:,3),'r')
            hold on
            loglog(Zvector_Titan_right(:,1),Zvector_Titan_right(:,3),'m')
            hold on
            loglog(Zvector_ER10x_right(:,1),Zvector_ER10x_right(:,3),'g')
            xlim(fax)
            ylabel('Z mag (mks ohms)')
            ylim(fay_Zmag)
             
            subplot(326)
            semilogx(Zvector_Mimosa_right(:,1),Zvector_Mimosa_right(:,4),'r')
            hold on
            semilogx(Zvector_Titan_right(:,1),Zvector_Titan_right(:,4),'m')
            hold on
            semilogx(Zvector_ER10x_right(:,1),Zvector_ER10x_right(:,4),'g')
            xlim(fax)
            ylim(fay_Zang)
            xlabel('Frequency (Hz)')
            ylabel('Z angle (cycles)')
            legend('Mimosa R', 'Titan R','ER10x R','Location','NorthWest')
        
 end
