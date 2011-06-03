. $libDir\string.ps1

Describe "Check string contain ignore case" {
    it "check string contain ignore case" {
	    (Contains-IgnoreCase "Test" "ES").should.be($true)
	}
}