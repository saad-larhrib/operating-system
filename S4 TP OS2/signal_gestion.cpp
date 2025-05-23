#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>

// Function: handler
// -----------------
// Handles the SIGUSR1 signal when received by a child process.
//
// Parameters:
// - sig: The signal number received (expected to be SIGUSR1).
//
// Behavior:
// - Prints a message indicating the signal number and the PID of the process
//   that received it.
//
// Example Output:
//   the signal 10 is received pid : 12345
void handler(int sig){
	printf("the signal %d is recieved pid : %d\n", sig, getpid());
}

// Function: emptyParentHandler
// ----------------------------
// Empty signal handler for the parent process to override the default
// behavior of SIGUSR1 (which would normally terminate the process).
//
// Parameters:
// - sig: The signal number received.
//
// Note:
// - This prevents the parent from terminating when it receives SIGUSR1
//   via `kill(0, SIGUSR1)` which sends the signal to the entire process group.
void emptyParentHandler(int sig){
	//this is empty handler for the parent process
}

int main(){
	// Set an empty handler in the parent process to catch SIGUSR1
	signal(SIGUSR1, emptyParentHandler);

	pid_t pid1, pid2;

	// First fork to create the first child
	pid1 = fork();
	if(pid1 < 0){
		// fork failed
		printf("error");
		exit(1); 
	}else if(pid1 == 0){
		// This block is executed by the first child
		printf("This is the child process pid : %d\n", getpid());

		// Set up handler to catch SIGUSR1
		signal(SIGUSR1, handler);

		// Wait for a signal
		pause();

		// Exit after handling the signal
		exit(0);
	}else{
		// Still in parent, create second child
		pid2 = fork();
		if(pid2 == 0){
			// This block is executed by the second child
			printf("This is the child process pid : %d\n", getpid());

			// Set up handler to catch SIGUSR1
			signal(SIGUSR1, handler);

			// Wait for a signal
			pause();

			// Exit after handling the signal
			exit(0);	
		}	
	}

	// Parent process continues here
	printf("This is the parent process : %d\n", getpid());

	// Wait a bit to ensure children have set up their signal handlers
	sleep(2);

	// Send SIGUSR1 to all processes in the same process group
	kill(0, SIGUSR1);

	// Sleep to keep the parent alive while children handle the signal
	sleep(30);

	// Wait for both children to finish
	wait(NULL);
	wait(NULL);

	return 0;
}