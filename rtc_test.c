#include <sys/time.h>
#include <time.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <linux/android_alarm.h>
#include <linux/rtc.h>

#include <stdlib.h>
#include "rtc_test.h"

int  rtc_xopen(int flags)
{
	int rtc;
	char major_rtc[] = "/dev/rtc";
	char minor_rtc[] = "/dev/rtc0";
	
	rtc = open(major_rtc, flags);
	if (rtc < 0)
	{
		rtc = open(minor_rtc, flags);
		if(rtc >= 0)
		{
			printf("open %s\n",minor_rtc);
		}
		else
		{
			printf("open %s failed:%s\n",minor_rtc,strerror(errno));
		}
	}
	else
	{
		printf("open %s\n",major_rtc);
	}


	return rtc;
}

int  rtc_read_tm(struct tm *ptm, int fd)
{
	int ret;
	memset(ptm, 0, sizeof(*ptm));

	ret = ioctl(fd, RTC_RD_TIME, ptm);
	if(ret < 0)
	{
		printf("read rtc failed:%s\n" ,strerror(errno)); 
	}
	else
	{
		ptm->tm_isdst = -1; /* "not known" */
	}

	return ret;
}

static time_t read_rtc()
{
	struct tm tm_time;
	int fd;
	int ret;

	fd = rtc_xopen(O_RDONLY);
	if(fd < 0)
	{
		return fd;
	}
	else
	{
		ret = rtc_read_tm(&tm_time, fd);
	}

	close(fd);
	if(ret < 0)
		return ret;
	else
		return  mktime(&tm_time);
}

int get_system_time(char *dt)
{    
	int fd;
	time_t t;
	
	#if 1
	time_t timep;
	struct tm *p;
	timep = read_rtc();
	if(timep <= 0)
		return timep;
	else
		p = localtime(&timep);    
	sprintf(dt,"%04d-%02d-%02d %02d:%02d:%02d",(1900+p->tm_year),(1+p->tm_mon),p->tm_mday,p->tm_hour,p->tm_min,p->tm_sec); 
	//printf("time is %s \n",dt);    
	#else
	struct timeval tv;
   	gettimeofday(&tv, NULL);
	printf("%s>>>>>tv.tv_sec:%ld>>tv.tv_usec:%d\n",__func__,tv.tv_sec,tv.tv_usec);
	#endif

	return timep;
	
	
	
	return 0;
}

int set_system_time(struct timeval *tv)
{    
	int ret;
	int fd;
	
	#if 0
	if(settimeofday(tv, NULL) < 0)   
	{        
		printf("Set system datatime error:%s\n" ,strerror(errno));        
		return 0;    
	}    
	else    
	{    
		printf("Set system datatime successfully!\n");       
		return 1;    
	}
	#else
	fd = open("/dev/alarm", O_RDWR);
	if(fd < 0)
	{
		printf("open /dev/alarm failed:%s\n" ,strerror(errno)); 
		return -1;
	}
    	ret = ioctl(fd, ANDROID_ALARM_SET_RTC, tv);
	if(ret < 0)
	{
		printf("set rtc failed:%s\n" ,strerror(errno));
		return -1;
	}
	#endif
	return 0;
}  

void* rtc_test(void *argc)
{
	char dt[30]={"20120926.132600"};
	struct rtc_msg *rtc_msg = (struct rtc_msg*)argc;
	int ret;
	struct tm tm;
	struct timeval tv;
	char *s = rtc_msg->date;
	int day = atoi(s);
	int hour;
	time_t t;
	
	
	struct timespec ts;

	while (*s && *s != '.')
		s++;

	if (*s)
		s++;

	hour = atoi(s);

	//printf("day:%d>>hour:%d\n",day,hour);
	tm.tm_year = day / 10000 - 1900;
	tm.tm_mon = (day % 10000) / 100 - 1;
	tm.tm_mday = (day % 100);
	tm.tm_hour = hour / 10000;
	tm.tm_min = (hour % 10000) / 100;
	tm.tm_sec = (hour % 100);
	tm.tm_isdst = -1;

    	tv.tv_sec = mktime(&tm);
	tv.tv_usec = 0;
	printf("set rtc time :%lu\n",tv.tv_sec);
	ret = set_system_time(&tv);
	if(ret < 0)
	{
		rtc_msg->result = -1;
	}
	else
	{
		t = get_system_time(rtc_msg->date);
		if(t < 0)
			rtc_msg->result = -1;
		else
		{
			if((t - tv.tv_sec > 10))
			{
				printf("test rtc failed:settime:%lu>>read time:%lu\n",
					tv.tv_sec,t);
				rtc_msg->result = -1;
			}
			else
			{
				rtc_msg->result = 0;
			}
		}
	}
	
	return argc;
}

