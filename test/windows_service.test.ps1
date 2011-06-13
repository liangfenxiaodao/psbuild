. $libDir\windows_service.ps1

Describe "Test scenario about windows service" {
   
    it "should return true when test service after create specific service" {
    	Create-Service "TestService" "C:\Windows\System32\notepad.exe"
    	(Test-Service "TestService").should.be($True)
    	Delete-Service "TestService"
	}


	 it "should return false when specific service does not existed" {
		 (Test-Service "TestService").should.be($False)
	}

	 it "should return true when create service successfully " {
    	(Create-Service "TestService" "C:\Windows\System32\notepad.exe").should.be($True)
	    Delete-Service "TestService"
	}

	it "should return false when create service fail due to specific service existed" {
	    (Create-Service "TestService" "C:\Windows\System32\notepad.exe").should.be($True)
	    (Create-Service "TestService" "C:\Windows\System32\notepad.exe").should.be($False)
	    Delete-Service "TestService"
	}

	it "should return false when create service fail due to exe not found" {
	   (Create-Service "TestService" "C:\Windows\System32\notepad123.exe").should.be($False)
	    Delete-Service "TestService"
	}

	it "should return true when delete service successfully " {
	    Create-Service "TestService" "C:\Windows\System32\notepad.exe"
	    (Test-Service "TestService").should.be($True)
	    (Delete-Service "TestService").should.be($True)
	}

	it "should return false when delete non-existed service " {
	    (Delete-Service "TestService").should.be($False)
	}

}