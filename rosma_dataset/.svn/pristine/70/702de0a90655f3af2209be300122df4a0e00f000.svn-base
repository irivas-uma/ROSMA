#include "rosma_dataset.h"

using namespace std;
float data[169];

/*
void cb_geometry_msgs(const geometry_msgs::PoseStamped::ConstPtr& msg)
{
  data[0] = msg->pose.position.x;
  data[1] = msg->pose.position.y;
  data[2] = msg->pose.position.z;
}

int main(int argc, char** argv)
{
  ros::init(argc, argv, "rosma");
  ros::NodeHandle nh;
  ros::Rate loop_rate(50);

  ros::Subscriber sub[18];
  sub[0] = nh.subscribe("/dvrk/MTML/position_cartesian_current",1000, &cb_geometry_msgs);

  ofstream File("dataset.csv");
  File << "\"MTML_pos_x\""  <<","<<"\"MTML_pos_y\"" <<","<<"\"MTML_pos_y\"" <<","<< endl;


  while(ros::ok())
  {
    ros::spinOnce();

    //for int i=

    loop_rate.sleep();
  }

  return(0);
}
*/


rosma::rosma(int argc,char **argv, std::string node_name)
  :n(node_name), ros_freq(0), node_name(node_name)
{

  slave_pose_current_callbacks[0] = &rosma::Slave0CurrentPoseCallback;
  slave_pose_current_callbacks[1] = &rosma::Slave1CurrentPoseCallback;

  slave_pose_desired_callbacks[0] = &rosma::Slave0DesiredPoseCallback;
  slave_pose_desired_callbacks[1] = &rosma::Slave1DesiredPoseCallback;

  master_pose_current_callbacks[0] = &rosma::Master0CurrentPoseCallback;
  master_pose_current_callbacks[1] = &rosma::Master1CurrentPoseCallback;

  slave_twist_callbacks[0] = &rosma::Slave0TwistCallback;
  slave_twist_callbacks[1] = &rosma::Slave1TwistCallback;

  master_joint_state_callbacks[0] = &rosma::Master0JointStateCallback;
  master_joint_state_callbacks[1] = &rosma::Master1JointStateCallback;

  gripper_callbacks[0] = &rosma::Master1GripperCallback;
  gripper_callbacks[1] = &rosma::Master2GripperCallback;

  master_twist_callbacks[0] = &rosma::Master0TwistCallback;
  master_twist_callbacks[1] = &rosma::Master1TwistCallback;

  master_wrench_callbacks[0] = &rosma::Master0WrenchCallback;
  master_wrench_callbacks[1] = &rosma::Master1WrenchCallback;

  GetROSParameterValues();
  run();
}


//-----------------------------------------------------------------------------------
// GetROSParameterValues
//-----------------------------------------------------------------------------------

void rosma::GetROSParameterValues() {

    ros_rate = new ros::Rate(30);

    n.param<int>("number_of_arms", n_arms, 0);
    ROS_INFO("Expecting '%d' arm(s)", n_arms);

    if (n_arms < 1)
        ROS_WARN("No arm specified. Can't perform data recording");

    subscriber_slave_pose_current = new ros::Subscriber[n_arms];
    subscriber_master_pose_current = new ros::Subscriber[n_arms];
    subscriber_slave_pose_desired = new ros::Subscriber[n_arms];
    subscriber_slave_twist = new ros::Subscriber[n_arms];
    subscriber_master_joint_state = new ros::Subscriber[n_arms];
    subscriber_master_current_gripper = new ros::Subscriber[n_arms];
    subscriber_master_twist = new ros::Subscriber[n_arms];
    subscriber_master_wrench = new ros::Subscriber[n_arms];

    // arm names
    for (int n_arm = 0; n_arm < n_arms; n_arm++) {

        //getting the name of the arms
        std::stringstream param_name;
        param_name << std::string("slave_") << n_arm + 1 << "_name";
        if(!n.getParam(param_name.str(), slave_names[n_arm]))
            throw std::runtime_error("No slave names found");

        param_name.str("");
        param_name << std::string("master_") << n_arm + 1 << "_name";
        if(!n.getParam(param_name.str(), master_names[n_arm]))
            throw std::runtime_error("No Master names found");

        // subscribers

        // the current pose of the slaves
        param_name.str("");
        param_name << std::string("/dvrk/") << slave_names[n_arm]
                   << "/position_cartesian_current";
        subscriber_slave_pose_current[n_arm] = n.subscribe(param_name.str(), 1
            ,slave_pose_current_callbacks[n_arm],this);

        // the current pose of the masters
        param_name.str("");
        param_name << std::string("/dvrk/") << master_names[n_arm]
                   << "/position_cartesian_current";
        subscriber_master_pose_current[n_arm] = n.subscribe(param_name.str(), 1
            ,master_pose_current_callbacks[n_arm], this);

        //  master's joint state
        param_name.str("");
        param_name << std::string("/dvrk/") << master_names[n_arm]
                   << "/state_joint_current";
        subscriber_master_joint_state[n_arm] = n.subscribe(param_name.str(), 1
            , master_joint_state_callbacks[n_arm], this);

        //  master's gripper
        param_name.str("");
        param_name << std::string("/dvrk/") <<master_names[n_arm]
                   << "/gripper_position_current";
        subscriber_master_current_gripper[n_arm] =n.subscribe(param_name.str()
            , 1, gripper_callbacks[n_arm], this);

        //  master's twist
        param_name.str("");
        param_name << std::string("/atar/") << master_names[n_arm]
                   << "/twist_filtered";
        subscriber_master_twist[n_arm] = n.subscribe(param_name.str(),1
            ,master_twist_callbacks[n_arm], this);

        //  Slave's twist
        param_name.str("");
        param_name << std::string("/dvrk/") << slave_names[n_arm]
                   << "/twist_body_current";
        subscriber_slave_twist[n_arm] = n.subscribe(param_name.str(), 1
            ,slave_twist_callbacks[n_arm], this);

        //master's wrench
        param_name.str("");
        param_name << std::string("/dvrk/") << master_names[n_arm]
                   << "/set_wrench_body";
        subscriber_master_wrench[n_arm] = n.subscribe(param_name.str(), 1
            ,master_wrench_callbacks[n_arm], this);
    }
}

void rosma::run(){

  while(ros::ok())
  {

    ros::spinOnce();
    ros_rate->sleep();
  }
}

// START OF THE ROS NODE
int main(int argc, char **argv){
  ros::init(argc, argv, "rosma");
  return 0;
}
