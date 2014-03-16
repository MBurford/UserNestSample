//
//  ViewController.m
//  UserNestTestApp
//
//  Copyright (c) 2014 UserNest, Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
	UserNestViewController	*userNest;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)clickLogin:(id)sender {
    //!!Fill in the AppID below with your own!!
	userNest = [[UserNestViewController alloc] initWithAppID:@"XXXXXX" delegate:self];
	[self presentViewController:userNest animated:YES completion:nil];
}

- (IBAction)clickLoginBlock:(id)sender {
    //!!Fill in the AppID below with your own!!
	userNest = [[UserNestViewController alloc] initWithAppID:@"XXXXXX" completionHandler:^(Boolean loggedIn, NSDictionary *loginData) {
		if (loggedIn) {
			[[[UIAlertView alloc] initWithTitle:@"Logged In!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
		} else {
			[[[UIAlertView alloc] initWithTitle:@"Not Logged In" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
		}
	}];
	[self presentViewController:userNest animated:YES completion:nil];
}


- (IBAction)clickCheck:(id)sender {
	[userNest checkIsLoggedInCompletionHandler:^(Boolean loggedIn) {
		if (loggedIn) {
			[[[UIAlertView alloc] initWithTitle:@"Logged In!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
		} else {
			[[[UIAlertView alloc] initWithTitle:@"Not Logged In" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
		}
	}];
}

- (IBAction)clickLogout:(id)sender {
    [userNest logoutCompletionHandler:^(Boolean invalidatedSession) {
		if (invalidatedSession) {
			[[[UIAlertView alloc] initWithTitle:@"Logged Out & Invalidated Session!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
		} else {
			[[[UIAlertView alloc] initWithTitle:@"Logged Out" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
		}
    }];
}

- (IBAction)clickLoginIfNeeded:(id)sender {
	//Completion handler that is called if the user gets the Login prompt
	userNest = [[UserNestViewController alloc] initWithAppID:@"XXXXXX" completionHandler:^(Boolean loggedIn, NSDictionary *loginData) {
		if (loggedIn) {
			[[[UIAlertView alloc] initWithTitle:@"Logged In!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
		} else {
			[[[UIAlertView alloc] initWithTitle:@"Login Failed :(" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
		}
	}];
	
	//Check if it's even needed!  Restores a previous session if they are already logged in.
	[userNest checkIsLoggedInCompletionHandler:^(Boolean loggedIn) {
		if (loggedIn) {
			//They are logged in already!
			[[[UIAlertView alloc] initWithTitle:@"Logged In!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
		} else {
            //Not logged in, present the UI to let them
			[self presentViewController:userNest animated:YES completion:nil];
		}
	}];
	//Note you could do much the same IsLoggedIn check using UserNestNetwork.
	//The UserNestViewController version is a very light wrapper that uses the SessionID
	//from the last successfule login so you don't have to save & restore the SessionID yourself.
	//UserNestNetwork	*userNestNetwork = [[UserNestNetwork alloc] initWithUserNestAppID:@"XXXXXX" session:@"SESSION_ID"];
    //[userNestNetwork checkIsLoggedInCompletionHandler:^(Boolean loggedIn) {  ...
}

- (void)userNestLoginSuccessUserData:(NSDictionary*)loginData {
	[[[UIAlertView alloc] initWithTitle:@"Logged In!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}
- (void)userNestLoginFailed {
	[[[UIAlertView alloc] initWithTitle:@"Login Failed :(" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}


@end
