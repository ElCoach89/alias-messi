// ============================================================
// El Coach — Root Navigation
// ============================================================

import React from 'react';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { Ionicons } from '@expo/vector-icons';
import { Colors } from '../constants/theme';
import {
  RootTabParamList,
  HomeStackParamList,
  ProgramStackParamList,
  TimerStackParamList,
  ProgressStackParamList,
  ProfileStackParamList,
} from '../types';

// Screens
import HomeScreen from '../screens/Home/HomeScreen';
import ProgramScreen from '../screens/Program/ProgramScreen';
import WeekDetailScreen from '../screens/Program/WeekDetailScreen';
import WorkoutScreen from '../screens/Workout/WorkoutScreen';
import ProgressScreen from '../screens/Progress/ProgressScreen';
import ProfileScreen from '../screens/Profile/ProfileScreen';
import TimerScreen from '../screens/Timer/TimerScreen';
import TimerActiveScreen from '../screens/Timer/TimerActiveScreen';

const Tab = createBottomTabNavigator<RootTabParamList>();

// --- Stack Navigators ---

const HomeStack = createNativeStackNavigator<HomeStackParamList>();
function HomeStackNavigator() {
  return (
    <HomeStack.Navigator screenOptions={{ headerShown: false }}>
      <HomeStack.Screen name="Home" component={HomeScreen} />
      <HomeStack.Screen name="Workout" component={WorkoutScreen} />
    </HomeStack.Navigator>
  );
}

const ProgramStack = createNativeStackNavigator<ProgramStackParamList>();
function ProgramStackNavigator() {
  return (
    <ProgramStack.Navigator screenOptions={{ headerShown: false }}>
      <ProgramStack.Screen name="ProgramOverview" component={ProgramScreen} />
      <ProgramStack.Screen name="WeekDetail" component={WeekDetailScreen} />
      <ProgramStack.Screen name="Workout" component={WorkoutScreen} />
    </ProgramStack.Navigator>
  );
}

const TimerStack = createNativeStackNavigator<TimerStackParamList>();
function TimerStackNavigator() {
  return (
    <TimerStack.Navigator screenOptions={{ headerShown: false }}>
      <TimerStack.Screen name="TimerHome" component={TimerScreen} />
      <TimerStack.Screen name="TimerActive" component={TimerActiveScreen} />
    </TimerStack.Navigator>
  );
}

const ProgressStack = createNativeStackNavigator<ProgressStackParamList>();
function ProgressStackNavigator() {
  return (
    <ProgressStack.Navigator screenOptions={{ headerShown: false }}>
      <ProgressStack.Screen name="ProgressHome" component={ProgressScreen} />
    </ProgressStack.Navigator>
  );
}

const ProfileStack = createNativeStackNavigator<ProfileStackParamList>();
function ProfileStackNavigator() {
  return (
    <ProfileStack.Navigator screenOptions={{ headerShown: false }}>
      <ProfileStack.Screen name="ProfileHome" component={ProfileScreen} />
    </ProfileStack.Navigator>
  );
}

// --- Tab Navigator ---

type TabIconName = React.ComponentProps<typeof Ionicons>['name'];

const TAB_ICONS: Record<keyof RootTabParamList, { active: TabIconName; inactive: TabIconName }> = {
  HomeTab: { active: 'home', inactive: 'home-outline' },
  ProgramTab: { active: 'calendar', inactive: 'calendar-outline' },
  TimerTab: { active: 'timer', inactive: 'timer-outline' },
  ProgressTab: { active: 'stats-chart', inactive: 'stats-chart-outline' },
  ProfileTab: { active: 'person', inactive: 'person-outline' },
};

export default function RootNavigator() {
  return (
    <Tab.Navigator
      screenOptions={({ route }) => ({
        headerShown: false,
        tabBarStyle: {
          backgroundColor: Colors.surface,
          borderTopColor: Colors.border,
          borderTopWidth: 0.5,
          height: 85,
          paddingBottom: 28,
          paddingTop: 8,
        },
        tabBarActiveTintColor: Colors.primary,
        tabBarInactiveTintColor: Colors.textMuted,
        tabBarIcon: ({ focused, color, size }) => {
          const icons = TAB_ICONS[route.name];
          const iconName = focused ? icons.active : icons.inactive;
          return <Ionicons name={iconName} size={size} color={color} />;
        },
      })}
    >
      <Tab.Screen name="HomeTab" component={HomeStackNavigator} options={{ tabBarLabel: 'Home' }} />
      <Tab.Screen name="ProgramTab" component={ProgramStackNavigator} options={{ tabBarLabel: 'Program' }} />
      <Tab.Screen name="TimerTab" component={TimerStackNavigator} options={{ tabBarLabel: 'Timer' }} />
      <Tab.Screen name="ProgressTab" component={ProgressStackNavigator} options={{ tabBarLabel: 'Progress' }} />
      <Tab.Screen name="ProfileTab" component={ProfileStackNavigator} options={{ tabBarLabel: 'Profile' }} />
    </Tab.Navigator>
  );
}
