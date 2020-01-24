#ifndef _rosma_dataset_h
#define _rosma_dataset_h

#include <ros/ros.h>
#include <std_msgs/Char.h>
#include <std_msgs/Float32.h>
#include <sensor_msgs/JointState.h>
#include <geometry_msgs/Pose.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/TwistStamped.h>
#include <geometry_msgs/Wrench.h>
#include <iostream>
#include <fstream>
#include <string>


class rosma
{
    public:
	
        rosma(int argc,char **argv, std::string node_name);	
	~ rosma(){};

	void Slave0CurrentPoseCallback(const geometry_msgs::PoseStampedConstPtr &msg);
        void Slave1CurrentPoseCallback(const geometry_msgs::PoseStampedConstPtr &msg);

        void Slave0DesiredPoseCallback(const geometry_msgs::PoseStampedConstPtr &msg);
        void Slave1DesiredPoseCallback(const geometry_msgs::PoseStampedConstPtr &msg);

        void Master0CurrentPoseCallback(const geometry_msgs::PoseStampedConstPtr &msg);
        void Master1CurrentPoseCallback(const geometry_msgs::PoseStampedConstPtr &msg);

        void Slave0TwistCallback(const geometry_msgs::TwistStampedConstPtr &msg);
        void Slave1TwistCallback(const geometry_msgs::TwistStampedConstPtr &msg);

        void Master0JointStateCallback(const sensor_msgs::JointStateConstPtr &msg);
        void Master1JointStateCallback(const sensor_msgs::JointStateConstPtr &msg);

        void Master1GripperCallback(const std_msgs::Float32::ConstPtr &msg);
        void Master2GripperCallback(const std_msgs::Float32::ConstPtr &msg);

        void Master0TwistCallback(const geometry_msgs::TwistConstPtr &msg);
        void Master1TwistCallback(const geometry_msgs::TwistConstPtr &msg);

        void Master0WrenchCallback(const geometry_msgs::WrenchConstPtr &msg);
        void Master1WrenchCallback(const geometry_msgs::WrenchConstPtr &msg);

	void run();
    
private:
    int n_arms;
	
    void GetROSParameterValues();
    
    void (rosma::*slave_pose_current_callbacks[2])
            (const geometry_msgs::PoseStampedConstPtr &msg);

    void (rosma::*master_pose_current_callbacks[2])
            (const geometry_msgs::PoseStampedConstPtr &msg);

    void (rosma::*slave_pose_desired_callbacks[2])
            (const geometry_msgs::PoseStampedConstPtr &msg);

    void (rosma::*slave_twist_callbacks[2])
            (const geometry_msgs::TwistStampedConstPtr &msg);

    void (rosma::*master_joint_state_callbacks[2])
            (const sensor_msgs::JointStateConstPtr &msg);

    void (rosma::*gripper_callbacks[2])
            (const std_msgs::Float32::ConstPtr &msg);

    void (rosma::*master_twist_callbacks[2])
            (const geometry_msgs::TwistConstPtr &msg);

    void (rosma::*master_wrench_callbacks[2])
            (const geometry_msgs::Wrench::ConstPtr &msg);

public:
    ros::NodeHandle n;
    ros::Rate * ros_rate;
    double ros_freq;

    std::string node_name;
    std::string slave_names[2];
    std::string master_names[2];

    // NOTE: 0 stands for left and 1 for right;

    // current and desired cartesian poses of the slaves
    geometry_msgs::Pose slave_current_pose[2];

    geometry_msgs::Pose slave_desired_pose[2];

    geometry_msgs::Pose master_current_pose[2];

    // joint states
    sensor_msgs::JointState master_joint_state[2];

    // gripper
    double gripper_position[2];

    // twists
    geometry_msgs::Twist slave_twist[2];

    geometry_msgs::Twist master_twist[2];

    // wrenches
    geometry_msgs::Wrench master_wrench[2];

    // foot pedals;
    bool clutch_pedal_pressed;
    bool coag_pedal_pressed;

    //geometry_msgs::Pose cam_pose;

    // SUBSCRIBERS
    ros::Subscriber subscriber_ring_pose_current;
    ros::Subscriber subscriber_ring_pose_desired;

    ros::Subscriber * subscriber_slave_pose_current;
    ros::Subscriber * subscriber_slave_pose_desired;
    ros::Subscriber * subscriber_master_pose_current;

    ros::Subscriber * subscriber_master_joint_state;

    ros::Subscriber * subscriber_master_current_gripper;

    ros::Subscriber * subscriber_master_twist;
    ros::Subscriber * subscriber_slave_twist;
    ros::Subscriber * subscriber_master_wrench;


    ros::Subscriber subscriber_foot_pedal_coag;
    ros::Subscriber subscriber_foot_pedal_clutch;


};

#endif
