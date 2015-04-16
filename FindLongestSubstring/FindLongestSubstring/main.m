//
//  main.m
//  FindLongestSubstring
//
//  Created by Rohan Aurora on 4/15/15.
//  Copyright (c) 2015 Rohan Aurora. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NO_OF_CHARS 256

int longestUniqueSubsttr(char *str, int *begin, int *end)
{
    unsigned long n = strlen(str);
    int cur_len = 1;  // To store the lenght of current substring
    int max_len = 1;  // To store the result
    int prev_index;  // To store the previous index
    int i,beg=0,en=1;
    int *visited = (int *)malloc(sizeof(int)*NO_OF_CHARS);
    
    /* Initialize the visited array as -1, -1 is used to indicate that
     character has not been visited yet. */
    for (i = 0; i < NO_OF_CHARS;  i++)
        visited[i] = -1;
    
    /* Mark first character as visited by storing the index of first
     character in visited array. */
    visited[str[0]] = 0;
    
    /* Start from the second character. First character is already processed
     (cur_len and max_len are initialized as 1, and visited[str[0]] is set */
    for (i = 1; i < n; i++)
    {
        prev_index =  visited[str[i]];
        
        /* If the currentt character is not present in the already processed
         substring or it is not part of the current NRCS, then do cur_len++ */
        if (prev_index == -1 || i - cur_len > prev_index)
        {
            cur_len++;
            en=i;
        }
        
        /* If the current character is present in currently considered NRCS,
         then update NRCS to start from the next character of previous instance. */
        else
        {
            /* Also, when we are changing the NRCS, we should also check whether
             length of the previous NRCS was greater than max_len or not.*/
            if (cur_len > max_len)
            {
                max_len = cur_len;
                *begin=i-cur_len;
                *end=en;
            }
            cur_len = i - prev_index;
            
            if(cur_len==1)
                beg=i;
            else
                beg=cur_len-1;
            
            en=i;
        }
        
        visited[str[i]] = i; // update the index of current character
    }
    
    // Compare the length of last NRCS with max_len and update max_len if needed
    if (cur_len > max_len)
    {
        max_len = cur_len;
        *begin=i-cur_len;
        *end=en;
    }
    
    
    free(visited); // free memory allocated for visited
    
    return max_len;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        char str[] = "abcdabff";
        printf("The input string is %s \n", str);
        int begin=0,end=0;
        int len =  longestUniqueSubsttr(str, &begin, &end);
        printf("The length of the longest non-repeating character substring is %d\n", len);
        printf("start index = %d, end index = %d", begin, end);
        
        getchar();
        return 0;
        
    }
}


