Polycom® SoundPoint® IP, SoundStation® IP and VVX® 1500 UC Software Release 3.3.5

This UC Software feature release applies to currently shipped SoundPoint IP, SoundStation IP, and VVX 1500 Bussiness media phones deployed on SIP networks.

Polycom recommends to use the latest BootROM 4.3.2 for all the platforms except VVX1500. 
For VVX1500 the BootROM image is not shipped separately it comes along with the 3.3.5 UC software application. 


WARNINGS:  

  1. The configuration files, their respective parameters and defaults, as well as the     
     provisioning methods have been simplified but extensively modified compared to
     previous releases. MANY OF THESE CHANGES ARE NOT BACKWARD-COMPATIBLE with 
     configuration files generated for earlier software releases.

     Polycom recommends that you first familiarize yourself with the changes         
     outlined in the “Administrator’s Guide for the Polycom® UC Software – 3.3.0” and 
     Technical Bulletin 60519, “Simplified Configuration Improvements in Polycom® 
     UC Software 3.3.0” before proceeding to configure the respective product.
     This Technical Bulletin is available from the Polycom® Support site. 
     

  2. The UCS 3.3.5 distributable files contain both the BootROM and SIP software. 
          There are new procedures to upgrade or downgrade  your phone to the
     UCS 3.3.5 release. 

     Polycom recommends that you first familiarize yourself with the information
     in Engineering Advisory 68081 "Announcing New Polycom® UC Software Installation
     Changes" before upgrading or downgrading your phone to UCS 3.3.5 from the current version on your phone.
      This Engineering Advisory is available from the Polycom® Support site. 


  3. The SoundPoint IP 300, 301, 430, 500, 501, 600, 601, SoundStation IP          
     4000, Spectralink 84xx and VVX 500 & 600 products are not supported in this release. 
     Customers using these products should refer to Technical Bulletin 35311 for
     instructions on how to configure the phones. 
     This Technical Bulletin is available from the Polycom® Support site.

     
This Release supports the following products:
   SoundPoint IP 235T    
   SoundPoint IP 320, 330
   SoundPoint IP 321, 331
   SoundPoint IP 335 
   SoundPoint IP 450
   SoundPoint IP 550
   SoundPoint IP 560
   SoundPoint IP 650
   SoundPoint IP 670
   SoundStation IP 5000
   SoundStation IP 6000
   SoundStation IP 7000
   VVX 1500
  

For build-id information, refer to the sip.ver file included in the release Zip file.
For details on changes in this build, refer to the relevant Release Notes.

Recommended Upgrade Process:

  1. Unzip the contents of the release zip file.

  2. Place the respective sip.ld file into the appropriate location on the provisioning
     server.

  3. Update your configuration files to use the template files contained in the release         
     zip file. In particular ensure that you use the new config files as there may be
     changes that are required for proper phone operation. Refer to the 
     documentation included with your softswitch provider and/or follow the recommended 
     practices in the reference documents listed below.

  4. Place the dictionary files into the appropriate location on the provisioning server.

  5. On the next phone reboot, the phones will automatically detect the new software and
     load it. In this case, the reboot will take slightly longer than a typical reboot.

  6. Confirm that the phone has loaded the correct software:
   a) If you have physical access to the phone, select 
      Menu->Status->Platform->Application->Main and confirm that the Version number 
      matches that detailed in the Release Notes and in the sip.ver file.
   b) If the phones are being remotely upgraded, the version identifier may be verified by
      examining the phone application log file.

The following reference documents are available from Polycom® Support web pages:
  1. Release Notes UCS 3.3.5
  2. Administrators' Guide UCS 3.3.0
  3. Technical Bulletin 60519 Simplified Configuration Improvements in Polycom® 
     UC Software 3.3.0
  4. Engineering Advisory 68081 "Announcing New Polycom® UC Software Installation        
     Changes"



Trademark Information
Polycom®, SoundPoint®, SoundStation®, VVX® and the Polycom logo design are registered trademarks of Polycom, Inc. 
in the U.S. and various countries. All other trademarks are the property of their respective companies.
