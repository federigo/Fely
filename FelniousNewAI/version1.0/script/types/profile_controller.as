#include "../helpers.as"
#include "profile.as"

funcdef void MainUpdateDelegate(Profile@ profile);

class ProfileController {  

    Profile _profile;
    MainUpdateDelegate@ MainUpdateHandler;

	ProfileController(Profile profile) {
        _profile = profile;	
	}

    ProfileController() {
        _profile = Profile();	
	}

    void MainUpdate() {
        if ((_profile !is null) && (MainUpdateHandler !is null)) {
            MainUpdateHandler(@_profile);
        }
    }

}